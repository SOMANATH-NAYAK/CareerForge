from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import json

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

# ========================================
# DIRECT DATABASE CONFIG - NO .env NEEDED!
# ========================================
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',  # XAMPP = '', MySQL Installer = 'your_password'
    'database': 'career_recommender',
    'port': 3306
}


def get_db_connection():
    """Create and return MySQL connection"""
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except mysql.connector.Error as err:
        print(f"❌ DB Error: {err}")
        return None

# Health check endpoint


@app.route('/health', methods=['GET'])
def health_check():
    conn = get_db_connection()
    if conn:
        conn.close()
        return jsonify({
            'status': 'healthy',
            'service': 'Career Recommender API v1.0',
            'database': DB_CONFIG['database']
        })
    return jsonify({'status': 'database_error'}), 500

# Get all careers endpoint


@app.route('/api/careers', methods=['GET'])
def get_all_careers():
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Database connection failed'}), 500

    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM careers ORDER BY title")
        careers = cursor.fetchall()
        cursor.close()
        conn.close()

        return jsonify({
            'success': True,
            'careers': careers,
            'count': len(careers)
        })
    except mysql.connector.Error as err:
        if conn:
            conn.close()
        return jsonify({'error': f'Database error: {str(err)}'}), 500
    except Exception as e:
        if conn:
            conn.close()
        return jsonify({'error': str(e)}), 500

# MAIN RECOMMENDATION ENDPOINT


@app.route('/api/recommend', methods=['POST'])
def recommend_careers():
    try:
        data = request.get_json()

        if not data:
            return jsonify({'error': 'No JSON data received'}), 400

        education = data.get('education', '').lower().strip()
        interests = [i.lower().strip() for i in data.get('interests', [])]
        skills = [s.lower().strip() for s in data.get('skills', [])]
        industries = [ind.lower().strip()
                      for ind in data.get('industries', [])]

        if not education:
            return jsonify({'error': 'Education is required'}), 400
        if not skills:
            return jsonify({'error': 'At least one skill is required'}), 400

        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Database unavailable'}), 500

        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM careers")
        careers = cursor.fetchall()
        cursor.close()
        conn.close()

        # 🔥 SMART SCORING ALGORITHM 🔥
        scored_careers = []
        for career in careers:
            score = 0
            reasons = []

            # 1. EDUCATION MATCH (35 points)
            career_edu = career['education'].lower()
            if education in career_edu or career_edu in education:
                score += 35
                reasons.append("✅ Perfect education match")

            # 2. SKILLS MATCH (15 points per skill)
            career_skills = json.loads(career['skills'] or '[]')
            matched_skills = [skill for skill in skills if
                              any(skill in cs.lower() for cs in career_skills)]
            if matched_skills:
                skill_score = len(matched_skills) * 15
                score += skill_score
                reasons.append(f"✅ {len(matched_skills)} skills matched")

            # 3. INTERESTS MATCH (20 points per match)
            career_text = (career['title'] + ' ' +
                           career['description']).lower()
            matched_interests = [interest for interest in interests
                                 if interest in career_text]
            if matched_interests:
                interest_score = len(matched_interests) * 20
                score += interest_score
                reasons.append(f"✅ Matches {len(matched_interests)} interests")

            # 4. INDUSTRY MATCH (25 points per match)
            career_industries = json.loads(career['industries'] or '[]')
            matched_industries = [ind for ind in industries
                                  if any(ind in ci.lower() for ci in career_industries)]
            if matched_industries:
                industry_score = len(set(matched_industries)) * 25
                score += industry_score
                reasons.append(
                    f"✅ {len(set(matched_industries))} industries match")

            if score >= 25:
                scored_careers.append({
                    'career': career,
                    'score': round(score, 1),
                    'match_percentage': round((score / 185) * 100, 1),
                    'reasons': reasons[:4]
                })

        recommendations = sorted(
            scored_careers, key=lambda x: x['score'], reverse=True)[:5]

        return jsonify({
            'success': True,
            'recommendations': recommendations,
            'total_careers_evaluated': len(scored_careers),
            'average_score': round(sum(r['score'] for r in recommendations) / max(1, len(recommendations)), 1),
            'best_match_score': recommendations[0]['score'] if recommendations else 0
        })

    except KeyError as e:
        return jsonify({'error': f'Missing field: {str(e)}'}), 400
    except mysql.connector.Error as err:
        return jsonify({'error': f'Database error: {str(err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Server error: {str(e)}'}), 500


@app.route('/api/test', methods=['GET'])
def test_recommendation():
    return jsonify({
        'message': 'Career API is working!',
        'endpoints': ['/api/recommend (POST)', '/api/careers (GET)', '/health (GET)']
    })


if __name__ == '__main__':
    print("🚀 Starting Career Recommendation API")
    print(f"📡 Server: http://localhost:5000")
    print(f"🗄️ Database: {DB_CONFIG['database']}@{DB_CONFIG['host']}")
    print("✅ CORS enabled for frontend")
    print("-" * 50)
    app.run(debug=True, host='0.0.0.0', port=5000)
-- ================================================
-- Career Recommender Database Schema - ENHANCED
-- Detailed Role Descriptions + Recommendation Reasons
-- ================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS career_recommender;
USE career_recommender;

-- Drop table if exists (fresh start)
DROP TABLE IF EXISTS careers;

-- Create Careers Table (exact structure your Flask expects)
CREATE TABLE careers (
    id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    education VARCHAR(50),
    skills JSON,
    industries JSON,
    salary VARCHAR(50),
    growth VARCHAR(20)
);

-- Insert 15 REAL Indian IT Careers with DETAILED DESCRIPTIONS
INSERT INTO careers (id, title, description, education, skills, industries, salary, growth) VALUES

-- 1. Full Stack Developer
(1, 'Full Stack Developer', 'Design, develop, and maintain complete web applications from frontend UI/UX to backend APIs and databases. Work with modern frameworks like React for interactive interfaces and Node.js/Python for scalable server-side logic. Deploy applications on cloud platforms and ensure seamless user experience across devices. Collaborate with designers, product managers, and QA teams to deliver production-ready solutions.', 'B.Tech CSE/IT', 
 '["JavaScript", "React", "Node.js", "Python", "MongoDB", "SQL", "Git", "Docker"]', 
 '["IT Services", "Tech Products", "Startups", "E-commerce"]', '₹8-25 LPA', 'Very High'),

-- 2. Data Scientist
(2, 'Data Scientist', 'Extract actionable insights from complex datasets using statistical analysis, machine learning algorithms, and data visualization. Clean and preprocess large datasets, build predictive models, perform A/B testing, and create dashboards for business stakeholders. Work with tools like Python, R, SQL, and visualization platforms to drive data-driven decision making.', 'B.Tech CSE/IT', 
 '["Python", "R", "SQL", "Pandas", "Machine Learning", "Tableau", "Statistics", "Power BI"]', 
 '["Analytics", "AI/ML", "Finance", "E-commerce", "Healthcare"]', '₹12-35 LPA', 'Very High'),

-- 3. DevOps Engineer  
(3, 'DevOps Engineer', 'Automate infrastructure deployment using CI/CD pipelines, container orchestration, and cloud-native technologies. Manage Kubernetes clusters, implement Infrastructure as Code (IaC), monitor application performance, and ensure zero-downtime deployments. Bridge the gap between development and operations teams for faster, reliable software delivery.', 'B.Tech CSE/IT', 
 '["AWS", "Docker", "Kubernetes", "Jenkins", "Linux", "CI/CD", "Terraform", "Prometheus"]', 
 '["Cloud Computing", "DevOps", "IT Services", "SaaS"]', '₹10-28 LPA', 'High'),

-- 4. Cybersecurity Analyst
(4, 'Cybersecurity Analyst', 'Protect organizational networks, systems, and data from cyber threats through vulnerability assessment, threat detection, and incident response. Implement security controls, conduct penetration testing, analyze security logs using SIEM tools, and develop defense strategies against evolving attack vectors.', 'B.Tech CSE/IT', 
 '["Ethical Hacking", "Networking", "Firewalls", "SIEM", "Python", "Wireshark", "Metasploit"]', 
 '["Cybersecurity", "IT Security", "Banking", "Government"]', '₹10-30 LPA', 'Very High'),

-- 5. Mobile App Developer
(5, 'Mobile App Developer', 'Build native and cross-platform mobile applications for iOS and Android using Flutter, React Native, or native technologies. Integrate push notifications, offline capabilities, and third-party APIs. Optimize app performance, ensure cross-device compatibility, and publish to App Store & Play Store.', 'B.Tech CSE/IT', 
 '["Flutter", "React Native", "Java", "Kotlin", "Swift", "Firebase", "REST APIs"]', 
 '["Mobile Development", "IT Services", "Startups", "Fintech"]', '₹7-22 LPA', 'High'),

-- 6. Blockchain Developer
(6, 'Blockchain Developer', 'Develop decentralized applications (DApps), smart contracts, and blockchain solutions using Solidity, Ethereum, and Web3 technologies. Design tokenomics, implement consensus mechanisms, integrate with wallets, and ensure blockchain security and scalability.', 'B.Tech CSE/IT', 
 '["Solidity", "Ethereum", "Web3.js", "JavaScript", "Rust", "IPFS", "Hardhat"]', 
 '["Blockchain", "Fintech", "Web3", "DeFi"]', '₹15-40 LPA', 'Very High'),

-- 7. Cloud Architect
(7, 'Cloud Architect', 'Design scalable, secure, and cost-optimized cloud infrastructure solutions across AWS, Azure, and GCP. Architect microservices, implement multi-region deployments, design disaster recovery strategies, and lead cloud migration projects for enterprise clients.', 'B.Tech CSE/IT', 
 '["AWS", "Azure", "GCP", "Kubernetes", "Terraform", "Serverless", "Cloud Security"]', 
 '["Cloud Computing", "IT Consulting", "Enterprise"]', '₹18-45 LPA', 'Very High'),

-- 8. AI/ML Engineer
(8, 'AI/ML Engineer', 'Research, develop, and deploy state-of-the-art machine learning models including computer vision, NLP, and recommendation systems. Optimize models for production using MLOps, deploy on cloud platforms, and work on cutting-edge AI research projects.', 'B.Tech CSE/IT', 
 '["Python", "TensorFlow", "PyTorch", "Computer Vision", "NLP", "MLOps", "Docker"]', 
 '["AI/ML", "Deep Learning", "Research", "Autonomous Systems"]', '₹15-40 LPA', 'Very High'),

-- 9. Frontend Developer
(9, 'Frontend Developer', 'Create pixel-perfect, responsive user interfaces using modern JavaScript frameworks and CSS technologies. Optimize frontend performance, implement pixel-perfect designs, ensure cross-browser compatibility, and build accessible web applications.', 'B.Tech CSE/IT', 
 '["React", "Vue.js", "Angular", "TypeScript", "CSS3", "Tailwind", "Web Vitals"]', 
 '["Frontend Development", "UI/UX", "Product", "E-commerce"]', '₹6-20 LPA', 'High'),

-- 10. Backend Developer
(10, 'Backend Developer', 'Build scalable server-side applications and REST/GraphQL APIs using Node.js, Python, or Java. Design database schemas, implement authentication/authorization, optimize query performance, and ensure high availability and security of backend systems.', 'B.Tech CSE/IT', 
 '["Node.js", "Python", "Django", "Express.js", "PostgreSQL", "Redis", "GraphQL"]', 
 '["Backend Development", "API Development", "Microservices"]', '₹8-22 LPA', 'High'),

-- 11. QA Automation Engineer
(11, 'QA Automation Engineer', 'Design and execute automated testing frameworks for web, mobile, and API testing. Create robust test automation suites using Selenium, Cypress, and Playwright. Implement test-driven development (TDD) and ensure 100% test coverage for critical features.', 'B.Tech CSE/IT', 
 '["Selenium", "Cypress", "Postman", "Python", "Java", "TestNG", "Page Object Model"]', 
 '["Quality Assurance", "Testing", "DevOps"]', '₹7-18 LPA', 'Medium'),

-- 12. Technical Writer
(12, 'Technical Writer', 'Create comprehensive technical documentation including API references, user guides, and developer manuals. Work with engineering teams to document complex systems, create interactive documentation portals, and ensure knowledge transfer across teams.', 'B.Tech CSE/IT', 
 '["Markdown", "Confluence", "Swagger", "Technical Writing", "API Documentation"]', 
 '["Technical Writing", "Documentation", "Developer Experience"]', '₹6-15 LPA', 'Medium'),

-- 13. Business Analyst
(13, 'Business Analyst', 'Translate complex business requirements into technical specifications and user stories. Conduct stakeholder interviews, create wireframes, define acceptance criteria, and bridge communication between business and technical teams.', 'B.Tech CSE/IT', 
 '["SQL", "Excel", "Jira", "Agile", "Requirement Analysis", "BPMN", "User Stories"]', 
 '["Business Analysis", "IT Consulting", "Product Management"]', '₹8-20 LPA', 'High'),

-- 14. Product Manager
(14, 'Product Manager', 'Define product vision, create roadmaps, prioritize features, and drive cross-functional teams to deliver customer value. Conduct market research, analyze user feedback, define KPIs, and ensure product-market fit through iterative development.', 'B.Tech CSE/IT', 
 '["Product Management", "Agile", "Jira", "Customer Research", "A/B Testing", "Analytics"]', 
 '["Product Management", "Tech Products", "Startups"]', '₹15-35 LPA', 'High'),

-- 15. Game Developer
(15, 'Game Developer', 'Design and develop engaging 2D/3D games using Unity and Unreal Engine. Implement game mechanics, physics systems, AI behaviors, and multiplayer networking. Optimize performance for mobile, PC, and console platforms.', 'B.Tech CSE/IT', 
 '["Unity", "Unreal Engine", "C#", "C++", "Game Design", "Physics", "Multiplayer"]', 
 '["Game Development", "Entertainment", "AR/VR"]', '₹8-25 LPA', 'Medium');

-- Verify data loaded successfully
SELECT COUNT(*) as total_careers FROM careers;
SELECT title, salary, growth FROM careers LIMIT 5;
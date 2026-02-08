// Wait for page load
document.addEventListener('DOMContentLoaded', function () {

    // Get DOM elements
    const form = document.getElementById('careerForm');
    const resultsDiv = document.getElementById('results');
    const careersList = document.getElementById('careersList');
    const loader = document.getElementById('loader');
    const submitBtn = document.getElementById('submitBtn');

    // Limit checkbox selections
    function limitCheckboxes(containerId, maxCount) {
        const checkboxes = document.querySelectorAll('#' + containerId + ' input[type="checkbox"]');

        checkboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                let checkedCount = 0;
                checkboxes.forEach(cb => {
                    if (cb.checked) checkedCount++;
                });

                if (checkedCount >= maxCount) {
                    checkboxes.forEach(cb => {
                        if (!cb.checked) cb.disabled = true;
                    });
                } else {
                    checkboxes.forEach(cb => cb.disabled = false);
                }
            });
        });
    }

    // Apply limits
    limitCheckboxes('interests', 4);
    limitCheckboxes('skills', 5);

    // Form submit handler
    form.addEventListener('submit', async function (e) {
        e.preventDefault();

        // Collect form data
        const formData = {
            education: document.getElementById('education').value,
            interests: getCheckedValues('interests'),
            skills: getCheckedValues('skills'),
            industries: getCheckedValues('industries')
        };

        // Validate
        if (!formData.education ||
            formData.interests.length === 0 ||
            formData.skills.length === 0) {
            alert('Please fill education, at least 1 interest and 1 skill!');
            return;
        }

        // Show loader
        showLoader(true);

        try {
            // Try Python backend first
            let response = await fetch('http://localhost:5000/api/recommend', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });

            // If Python fails, try Node.js
            if (!response.ok) {
                response = await fetch('http://localhost:3001/api/recommend', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                });
            }

            const data = await response.json();
            showResults(data.recommendations);

        } catch (error) {
            alert('Server error! Start Python (port 5000) or Node (port 3001) backend first.');
            console.error('Error:', error);
        } finally {
            showLoader(false);
        }
    });

    // Helper functions
    function getCheckedValues(containerId) {
        return Array.from(document.querySelectorAll('#' + containerId + ' input:checked'))
            .map(cb => cb.value);
    }

    function showLoader(show) {
        loader.style.display = show ? 'flex' : 'none';
        submitBtn.disabled = show;
        if (show) {
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Analyzing...';
        } else {
            submitBtn.innerHTML = '<i class="fas fa-magic"></i> Find My Career';
        }
    }

    function showResults(recommendations) {
        careersList.innerHTML = '';

        recommendations.forEach(function (rec) {
            const card = document.createElement('div');
            card.className = 'career-card';
            card.innerHTML = `
                <div class="score-tag">Score: ${rec.score}/100</div>
                <div class="career-name">${rec.career.title}</div>
                <p class="career-desc">${rec.career.description}</p>
                <div class="info-grid">
                    <div class="info-item">
                        <i class="fas fa-graduation-cap"></i> ${rec.career.education}
                    </div>
                    <div class="info-item">
                        <i class="fas fa-rupee-sign"></i> ${rec.career.salary}
                    </div>
                    <div class="info-item">
                        <i class="fas fa-chart-line"></i> ${rec.career.growth}
                    </div>
                </div>
                <div class="why-section">
                    <h4><i class="fas fa-check-circle"></i> Why Recommended:</h4>
                    <ul class="why-list">
                        ${rec.reasons.map(reason => `<li>${reason}</li>`).join('')}
                    </ul>
                </div>
            `;
            careersList.appendChild(card);
        });

        resultsDiv.style.display = 'block';
        resultsDiv.scrollIntoView({ behavior: 'smooth' });
    }
});
export function populateExperienceSection(workExperience) {
  const experienceSection = document.getElementById("experience");

  if (!experienceSection) {
    console.error('No element with id "experience" found.');
    return;
  }

  let html = `
      <div class="container">
          <div class="section-title">
              <h2>Professional Experience</h2>
          </div>
          <div class="row">
              <div class="col-lg-10" data-aos="fade-up" data-aos-delay="100">
  `;

  workExperience.forEach((job) => {
    html += `
          <div class="resume-item">
              <h4 class="resume-title">${job.title}</h4>
              <h5 class="date-badge">${job.dates}</h5>
              <p><em class="location">${job.location}</em></p>
              <ul>
                  ${job.responsibilities
                    .map((responsibility) => `<li>${responsibility}</li>`)
                    .join("")}
              </ul>
          </div>
      `;
  });

  html += `
              </div>
          </div>
      </div>
  `;

  experienceSection.innerHTML = html;
}

export function populateExpertiseSection(expertise) {
  const expertiseRows = document.getElementById("expertise-rows");

  if (!expertiseRows) {
    console.error('No element with id "expertise-rows" found.');
    return;
  }

  const html = expertise
    .map(
      (skill) => `
      <div class="service-container ${
        skill.bootstrapSize
      } icon-box" data-aos="fade-up" data-aos-delay="${skill.delay}">
        <div class="icon"><i class="bi ${skill.icon}"></i></div>
        <h4 class="skills-title">${skill.title}</h4>
        <div class="row">
          ${skill.bullets
            .map(
              (bullet) => `
              <div class="description-bullet">
                <i class="bi bi-arrow-right-circle-fill"></i>${bullet}
              </div>
            `
            )
            .join("")}
        </div>
      </div>
    `
    )
    .join("");

  expertiseRows.innerHTML += html;
}

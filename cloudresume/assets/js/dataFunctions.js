console.log("dataFunctions.js loaded");

export function sampleFunction() {
  console.log("Sample function executed");
}

export function professionalExperience() {
  return {
    experiences: [],
    async fetchExperienceData() {
      try {
        const response = await fetch("./data/experience.json");
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        const data = await response.json();
        console.log(data);
        this.experiences = data.ProfessionalExperience || [];
      } catch (error) {
        console.error("Error fetching experience data:", error);
      }
    },
  };
}

export function educationDetails() {
  return {
    education: [],
    async fetchEducationData() {
      try {
        const response = await fetch("/path/to/education-data.json");
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        const data = await response.json();
        this.education = data.Education || [];
      } catch (error) {
        console.error("Error fetching education data:", error);
      }
    },
  };
}

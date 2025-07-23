<script lang="ts">
  // TODO: Replace with real recommended courses data
  export let courses = [
    {
      id: 'python-101',
      title: 'Python for Beginners',
      instructor: 'Jane Doe',
      rating: 4.8,
      image: 'https://placehold.co/120x80',
      progress: 0,
      isEnrolled: false
    },
    {
      id: 'ml-intro',
      title: 'Intro to Machine Learning',
      instructor: 'John Smith',
      rating: 4.7,
      image: 'https://placehold.co/120x80',
      progress: 0.2,
      isEnrolled: true
    },
    {
      id: 'excel-essentials',
      title: 'Excel Essentials',
      instructor: 'Emily Chen',
      rating: 4.6,
      image: 'https://placehold.co/120x80',
      progress: 0,
      isEnrolled: false
    },
    {
      id: 'web-dev',
      title: 'Web Development Bootcamp',
      instructor: 'Alex Kim',
      rating: 4.9,
      image: 'https://placehold.co/120x80',
      progress: 0.5,
      isEnrolled: true
    }
  ];
  function handleStart(course: any) {
    // TODO: Replace with real navigation
    window.location.href = `/course/${course.id}`;
  }
</script>

<section class="recommended-section">
  <h2 class="recommended-title">Recommended for You</h2>
  <div class="recommended-row">
    {#each courses as course}
      <div class="recommended-card">
        <img class="course-img" src={course.image} alt={course.title} loading="lazy" />
        <div class="rec-course-info">
          <div class="rec-course-title">{course.title}</div>
          <div class="rec-course-instructor">{course.instructor}</div>
          <div class="rec-course-rating">
            <span class="star">★</span> {course.rating}
          </div>
          {#if course.isEnrolled}
            <div class="rec-progress-bar-container">
              <div class="rec-progress-bar" style="width: {Math.round(course.progress * 100)}%;"></div>
            </div>
            <button class="rec-btn continue" on:click={() => handleStart(course)}>Continue</button>
          {:else}
            <button class="rec-btn start" on:click={() => handleStart(course)}>Start</button>
          {/if}
        </div>
      </div>
    {/each}
    <a class="see-all-link" href="#">See All Recommendations →</a>
  </div>
</section>

<style>
.recommended-section {
  margin: 3.5rem 0 2.5rem 0;
  padding: 2rem 0 1.2rem 0;
  background: linear-gradient(135deg, #e0e7ff 0%, #f3e8ff 100%);
  border-radius: 2rem;
  box-shadow: 0 4px 32px rgba(124, 58, 237, 0.06);
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 1.5rem;
}
.recommended-title {
  font-family: 'Nunito', sans-serif;
  font-size: 1.5rem;
  font-weight: 800;
  color: #4A90E2;
  margin-left: 2.5rem;
  margin-bottom: 0.7rem;
}
.recommended-row {
  display: flex;
  gap: 2rem;
  overflow-x: auto;
  padding: 0 2.5rem;
  align-items: stretch;
}
.recommended-card {
  background: #fff;
  border-radius: 1.2rem;
  box-shadow: 0 2px 16px rgba(124, 58, 237, 0.06);
  padding: 1.2rem 1rem;
  min-width: 220px;
  max-width: 240px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.7rem;
  transition: box-shadow 0.18s, transform 0.18s;
  cursor: pointer;
}
.recommended-card:hover {
  box-shadow: 0 8px 32px rgba(124, 58, 237, 0.12);
  transform: translateY(-4px) scale(1.04);
}
.course-img {
  width: 120px;
  height: 80px;
  object-fit: cover;
  border-radius: 0.7rem;
  background: #ede9fe;
  box-shadow: 0 2px 8px rgba(124, 58, 237, 0.08);
}
.rec-course-info {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 0.3rem;
}
.rec-course-title {
  font-size: 1.05rem;
  font-weight: 700;
  color: #4A90E2;
  font-family: 'Nunito', sans-serif;
  margin-bottom: 0.1rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.rec-course-instructor {
  font-size: 0.97rem;
  color: #7c3aed;
  font-weight: 600;
  margin-bottom: 0.1rem;
}
.rec-course-rating {
  font-size: 0.97rem;
  color: #F5A623;
  font-weight: 700;
  margin-bottom: 0.2rem;
}
.star {
  color: #F5A623;
  font-size: 1.1rem;
  margin-right: 0.2rem;
}
.rec-progress-bar-container {
  width: 100%;
  height: 8px;
  background: #ede9fe;
  border-radius: 4px;
  overflow: hidden;
  margin: 0.2rem 0 0.4rem 0;
}
.rec-progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #F5A623 0%, #F8E71C 100%);
  border-radius: 4px;
  transition: width 0.3s cubic-bezier(0.4,0,0.2,1);
}
.rec-btn {
  margin-top: 0.3rem;
  padding: 0.6rem 1.5rem;
  border-radius: 1.2rem;
  border: none;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(245, 166, 35, 0.08);
  transition: background 0.18s, color 0.18s, transform 0.18s;
}
.rec-btn.start {
  background: linear-gradient(90deg, #F5A623 0%, #F8E71C 100%);
  color: #fff;
}
.rec-btn.start:hover {
  background: linear-gradient(90deg, #F8E71C 0%, #F5A623 100%);
  color: #fff;
  transform: scale(1.07);
}
.rec-btn.continue {
  background: linear-gradient(90deg, #10b981 0%, #34d399 100%);
  color: #fff;
}
.rec-btn.continue:hover {
  background: linear-gradient(90deg, #34d399 0%, #10b981 100%);
  color: #fff;
  transform: scale(1.07);
}
.see-all-link {
  align-self: center;
  margin-left: 1.5rem;
  font-size: 1.05rem;
  color: #4A90E2;
  font-weight: 700;
  text-decoration: none;
  padding: 0.7rem 1.2rem;
  border-radius: 1.2rem;
  background: #fff;
  box-shadow: 0 2px 8px rgba(124, 58, 237, 0.04);
  transition: background 0.18s, color 0.18s;
}
.see-all-link:hover {
  background: #4A90E2;
  color: #fff;
}
@media (max-width: 900px) {
  .recommended-row {
    gap: 1rem;
    padding: 0 0.7rem;
  }
  .recommended-card {
    min-width: 160px;
    max-width: 180px;
    padding: 0.7rem 0.3rem;
    border-radius: 0.7rem;
  }
  .see-all-link {
    font-size: 0.97rem;
    padding: 0.5rem 0.7rem;
    border-radius: 0.7rem;
  }
}
</style> 
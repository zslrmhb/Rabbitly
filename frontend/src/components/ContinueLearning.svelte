<script lang="ts">
  export let course = {
    title: 'Introduction to Data Science',
    thumbnail: 'https://placehold.co/120x80', // TODO: Replace with real image
    progress: 0.35,
    lastLesson: 'Lesson 15: Data Cleaning'
  };
  export let onResume: () => void = () => {};
</script>

<div class="continue-learning-card">
  <img class="course-thumb" src={course.thumbnail} alt={course.title} loading="lazy" />
  <div class="course-info">
    <div class="course-title">{course.title}</div>
    <div class="course-lesson">{course.lastLesson}</div>
    <div class="progress-bar-container">
      <div class="progress-bar" style="width: {Math.round(course.progress * 100)}%;"></div>
    </div>
    <div class="progress-label">{Math.round(course.progress * 100)}% complete</div>
    <button class="resume-btn" on:click={onResume}>Resume Learning</button>
  </div>
</div>

<style>
.continue-learning-card {
  display: flex;
  align-items: center;
  gap: 2rem;
  background: linear-gradient(90deg, #f3e8ff 0%, #e0e7ff 100%);
  border-radius: 1.5rem;
  box-shadow: 0 4px 24px rgba(80, 80, 120, 0.08);
  padding: 2rem 2.5rem;
  margin-bottom: 2.5rem;
  min-width: 0;
}
.course-thumb {
  width: 120px;
  height: 80px;
  object-fit: cover;
  border-radius: 1rem;
  box-shadow: 0 2px 8px rgba(124, 58, 237, 0.08);
  background: #fff;
}
.course-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.7rem;
  min-width: 0;
}
.course-title {
  font-size: 1.3rem;
  font-weight: 800;
  color: #4A90E2;
  font-family: 'Nunito', sans-serif;
  margin-bottom: 0.2rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.course-lesson {
  font-size: 1.05rem;
  color: #7c3aed;
  font-weight: 600;
  margin-bottom: 0.2rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.progress-bar-container {
  width: 100%;
  height: 10px;
  background: #ede9fe;
  border-radius: 5px;
  overflow: hidden;
  margin: 0.3rem 0;
}
.progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #F5A623 0%, #F8E71C 100%);
  border-radius: 5px;
  transition: width 0.3s cubic-bezier(0.4,0,0.2,1);
}
.progress-label {
  font-size: 0.97rem;
  color: #333;
  font-weight: 500;
  margin-bottom: 0.5rem;
}
.resume-btn {
  margin-top: 0.5rem;
  padding: 0.9rem 2.1rem;
  border-radius: 1.5rem;
  border: none;
  background: linear-gradient(90deg, #F5A623 0%, #F8E71C 100%);
  color: #fff;
  font-weight: 700;
  font-size: 1.1rem;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(245, 166, 35, 0.08);
  transition: background 0.18s, color 0.18s, transform 0.18s;
}
.resume-btn:hover {
  background: linear-gradient(90deg, #F8E71C 0%, #F5A623 100%);
  color: #fff;
  transform: scale(1.07);
}
@media (max-width: 700px) {
  .continue-learning-card {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
    padding: 1rem 0.7rem;
  }
  .course-thumb {
    width: 100px;
    height: 60px;
  }
  .course-title {
    font-size: 1.05rem;
  }
  .resume-btn {
    font-size: 0.97rem;
    padding: 0.5rem 1.2rem;
    border-radius: 0.8rem;
  }
}
</style> 
<script lang="ts">
  import courses from '../lib/data/courses.json';
  import { goto } from '$app/navigation';

  function openCourse(slug: string) {
    goto(`/courses/${slug}`);
  }
</script>

<h1>All Courses</h1>
<div class="course-list">
  {#each courses as course}
    <div class="course-card" tabindex="0" role="button" aria-label={course.title} on:click={() => openCourse(course.slug)} on:keydown={(e) => (e.key === 'Enter' || e.key === ' ') && openCourse(course.slug)}>
      <h2>{course.title}</h2>
      <p>{course.description}</p>
    </div>
  {/each}
</div>

<style>
.course-list {
  display: flex;
  flex-wrap: wrap;
  gap: 2rem;
}
.course-card {
  background: var(--grey-1, #f5f5f5);
  border-radius: 1rem;
  padding: 2rem;
  min-width: 220px;
  max-width: 320px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  cursor: pointer;
  outline: none;
  transition: box-shadow 0.2s;
}
.course-card:focus, .course-card:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.10);
}
</style> 
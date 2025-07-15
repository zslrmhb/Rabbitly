<script lang="ts">
  import courses from '../lib/data/courses.json';
  import RoadmapGraph from './RoadmapGraph.svelte';
  export let slug: string;

  const course = courses.find((c) => c.slug === slug);
</script>

{#if course}
  <h1>{course.title}</h1>
  <p>{course.description}</p>
  <RoadmapGraph roadmap={course.roadmap} />
{:else}
  <h1>Course not found</h1>
{/if} 
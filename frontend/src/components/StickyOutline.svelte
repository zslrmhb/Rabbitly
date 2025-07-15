<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  export let subTopics: { id: string; title: string }[] = [];
  let activeId = subTopics.length > 0 ? subTopics[0].id : '';
  let observer: IntersectionObserver;

  function scrollToSection(id: string) {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      history.replaceState(null, '', `#${id}`);
      activeId = id;
    }
  }

  onMount(() => {
    const sectionIds = subTopics.map(t => t.id);
    observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            activeId = entry.target.id;
            break;
          }
        }
      },
      {
        root: null,
        rootMargin: '0px 0px -60% 0px', // triggers when section top is 40% from top
        threshold: 0.1
      }
    );
    for (const id of sectionIds) {
      const el = document.getElementById(id);
      if (el) observer.observe(el);
    }
  });

  onDestroy(() => {
    if (observer) observer.disconnect();
  });
</script>

<nav class="outline-nav">
  <ul>
    {#each subTopics as topic}
      <li>
        <button
          class:active={activeId === topic.id}
          on:click={() => scrollToSection(topic.id)}
          aria-current={activeId === topic.id ? 'step' : undefined}
        >
          {topic.title}
        </button>
      </li>
    {/each}
  </ul>
</nav>

<style>
.outline-nav {
  position: sticky;
  top: 2rem;
  background: #fff;
  border-radius: 1rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  padding: 1.5rem 1rem;
}
.outline-nav ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
.outline-nav button {
  background: none;
  border: none;
  color: #333;
  font-size: 1rem;
  cursor: pointer;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  text-align: left;
  transition: background 0.2s;
}
.outline-nav button.active, .outline-nav button:focus {
  background: #e0e0e0;
  font-weight: bold;
}
</style> 
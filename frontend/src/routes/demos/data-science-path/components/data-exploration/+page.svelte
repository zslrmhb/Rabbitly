<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Data Exploration</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Data Exploration</h1>
  </div>
  <div class="content">
    <p>Content about data exploration will go here.</p>
  </div>
</div> 
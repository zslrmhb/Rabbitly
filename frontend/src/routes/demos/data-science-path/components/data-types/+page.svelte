<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Data Types</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Data Types</h1>
  </div>
  <div class="content">
    <p>Content about data types will go here.</p>
  </div>
</div> 
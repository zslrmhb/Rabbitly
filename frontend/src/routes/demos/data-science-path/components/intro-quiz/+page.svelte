<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Introduction Quiz</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Introduction Quiz</h1>
  </div>
  <div class="content">
    <p>This is the quiz for the introduction to data science.</p>
  </div>
</div> 
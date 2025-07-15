<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Data Fundamentals Quiz</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Data Fundamentals Quiz</h1>
  </div>
  <div class="content">
    <p>This is the quiz for data fundamentals.</p>
  </div>
</div> 
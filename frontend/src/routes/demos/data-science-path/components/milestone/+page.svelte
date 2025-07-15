<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Milestone</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>🎁 Milestone Achieved!</h1>
  </div>
  <div class="content">
    <p>Congratulations! You've reached a milestone in your data science journey.</p>
  </div>
</div> 
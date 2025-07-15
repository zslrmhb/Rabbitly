<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Achievement</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>🏆 Achievement Unlocked!</h1>
  </div>
  <div class="content">
    <p>You've earned a badge for completing this course!</p>
  </div>
</div> 
<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<svelte:head>
  <title>Environment Setup</title>
</svelte:head>

<div class="component-page">
  <div class="header">
    <button class="back-button" on:click={() => goto('/demos/data-science-path')}>
      ← Back to Roadmap
    </button>
    <h1>Environment Setup</h1>
  </div>
  <div class="content">
    <p>Instructions for setting up your data science environment will go here.</p>
  </div>
</div> 
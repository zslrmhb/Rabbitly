<script lang="ts">
  import type { PathNode } from '$lib/types';
  import { createEventDispatcher } from 'svelte';

  export let nodes: PathNode[] = [];
  export let activeNodeId: string = "";

  const dispatch = createEventDispatcher();

  function handleSelect(id: string, state: PathNode['state']) {
    if (state === 'locked') return;
    dispatch('select', id);
  }

  // Group nodes by sub-topic for proper rendering
  $: subTopicGroups = nodes.reduce((groups, node) => {
    if (!node.special) {
      const subTopic = node.subTopicId;
      if (!groups[subTopic]) {
        groups[subTopic] = [];
      }
      groups[subTopic].push(node);
    }
    return groups;
  }, {} as Record<string, PathNode[]>);

  // Get special nodes (chest, badge)
  $: specialNodes = nodes.filter(node => node.special);
</script>

<div class="learning-path">
  {#each Object.entries(subTopicGroups) as [subTopicId, subTopicNodes]}
    <!-- Sub-topic section -->
    <div class="sub-topic-section">
      <!-- Sub-topic divider -->
      <div class="sub-topic-divider">
        <div class="divider-line"></div>
        <span class="divider-title">SUB-TOPIC {subTopicId}</span>
        <div class="divider-line"></div>
      </div>

      <!-- Nodes for this sub-topic -->
      {#each subTopicNodes as node (node.id)}
        <button
          class="node {node.state} {node.id === activeNodeId ? 'active' : ''}"
          aria-current={node.id === activeNodeId ? 'step' : undefined}
          aria-disabled={node.state === 'locked'}
          on:click={() => handleSelect(node.id, node.state)}
        >
          {#if node.state === 'completed'}
            <span class="checkmark">✔</span>
          {:else if node.state === 'current'}
            <span class="star current">★</span>
          {:else}
            <span class="star future">★</span>
          {/if}
          <span class="node-label">{node.componentId}</span>
        </button>
      {/each}
    </div>
  {/each}

  <!-- Special milestone nodes -->
  {#each specialNodes as node (node.id)}
    <button
      class="node {node.state} {node.special} {node.id === activeNodeId ? 'active' : ''}"
      aria-current={node.id === activeNodeId ? 'step' : undefined}
      aria-disabled={node.state === 'locked'}
      on:click={() => handleSelect(node.id, node.state)}
    >
      {#if node.special === 'chest'}
        <span class="milestone-icon">🎁</span>
      {:else if node.special === 'badge'}
        <span class="milestone-icon">🏆</span>
      {/if}
      <span class="node-label">{node.componentId}</span>
    </button>
  {/each}
</div>

<style>
  :root {
    --accent-purple: #b78af0;  /* Sub-topic A */
    --accent-green:  #46cb2f;  /* Sub-topic B */
  }

  .learning-path {
    display: flex;
    flex-direction: column;
    gap: 16px;
    padding: 20px;
    background: #2a2a2a;
    border-radius: 12px;
    max-height: 60vh;
    overflow-y: auto;
    width: 400px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  /* Sub-topic sections */
  .sub-topic-section {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  /* Sub-topic divider */
  .sub-topic-divider {
    display: flex;
    align-items: center;
    margin: 8px 0;
  }

  .divider-line {
    flex: 1;
    height: 1px;
    background: rgba(255,255,255,0.3);
  }

  .divider-title {
    padding: 0 12px;
    color: rgba(255,255,255,0.7);
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  /* Node buttons */
  .node {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    transition: all 0.15s ease;
    background: #333;
    color: #fff;
    text-align: left;
    width: 100%;
  }

  .node:hover:not([aria-disabled="true"]) {
    background: #444;
    transform: translateX(4px);
  }

  .node.active {
    background: var(--accent-purple);
    box-shadow: 0 0 0 2px rgba(183, 138, 240, 0.3);
  }

  .node.completed {
    background: #2d5a2d;
  }

  .node.future {
    background: #333;
    opacity: 0.7;
  }

  .node.locked {
    background: #555;
    opacity: 0.5;
    cursor: not-allowed;
  }

  .node.locked:hover {
    transform: none;
    background: #555;
  }

  /* Icons */
  .checkmark {
    color: #fff;
    font-weight: bold;
    font-size: 16px;
  }

  .star {
    color: #fff;
    font-size: 16px;
  }

  .star.current {
    animation: glow 2s ease-in-out infinite alternate;
  }

  .star.future {
    opacity: 0.6;
  }

  .milestone-icon {
    font-size: 20px;
  }

  .node-label {
    font-size: 0.9rem;
    font-weight: 500;
  }

  @keyframes glow {
    from {
      text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff;
    }
    to {
      text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff;
    }
  }

  /* Scrollbar styling */
  .learning-path::-webkit-scrollbar {
    width: 6px;
  }

  .learning-path::-webkit-scrollbar-track {
    background: #1a1a1a;
    border-radius: 3px;
  }

  .learning-path::-webkit-scrollbar-thumb {
    background: #555;
    border-radius: 3px;
  }

  .learning-path::-webkit-scrollbar-thumb:hover {
    background: #777;
  }

  /* mobile responsive */
  @media (max-width: 768px) {
    .learning-path {
      width: 100%;
      max-width: 350px;
      max-height: 50vh;
    }
  }
</style> 
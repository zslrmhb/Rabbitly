<script lang="ts">
  import type { PathNode } from '$lib/types';
  import { createEventDispatcher } from 'svelte';

  export let nodes: PathNode[] = [];
  export let activeNodeId: string = "";
  export let streakDays: number = 5;
  export let dailyMission: string = "Complete 3 lessons today";
  export let rank: { position: number; total: number; percentile: number } = { position: 1250, total: 5000, percentile: 75 };

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
  <!-- Top Row: Streak and Mission -->
  <div class="top-row">
    <!-- Streak Counter -->
    <div class="streak-section">
      <div class="streak-icon">🔥</div>
      <div class="streak-info">
        <div class="streak-days">{streakDays} days</div>
        <div class="streak-label">Learning streak</div>
      </div>
    </div>

    <!-- Daily Mission -->
    <div class="mission-section">
      <div class="section-header">
        <div class="section-icon">📋</div>
        <span>Daily Mission</span>
      </div>
      <div class="mission-content">
        <div class="mission-text">{dailyMission}</div>
        <div class="mission-progress">
          <div class="progress-bar">
            <div class="progress-fill" style="width: 60%"></div>
          </div>
          <span class="progress-text">2/3 completed</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Rank Comparison -->
  <div class="rank-section">
    <div class="section-header">
      <div class="section-icon">🏆</div>
      <span>Your Rank</span>
    </div>
    <div class="rank-content">
      <div class="rank-position">#{rank.position}</div>
      <div class="rank-total">of {rank.total} learners</div>
      <div class="rank-percentile">Top {rank.percentile}%</div>
    </div>
  </div>

  <!-- Original Learning Path -->
  <div class="path-section">
    <div class="section-header">
      <div class="section-icon">🎯</div>
      <span>Learning Path</span>
    </div>
    <div class="path-content">
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
  </div>
</div>

<style>
  :root {
    --accent-purple: #b78af0;  /* Sub-topic A */
    --accent-green:  #46cb2f;  /* Sub-topic B */
  }

  .learning-path {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 20px;
    background: #2a2a2a;
    border-radius: 12px;
    max-height: 80vh;
    width: 400px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  }

  /* Top Row Container */
  .top-row {
    display: flex;
    gap: 12px;
  }

  /* Streak Section */
  .streak-section {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px;
    background: linear-gradient(135deg, #ff6b6b, #ff8e8e);
    border-radius: 12px;
    color: white;
    flex: 1;
  }

  .streak-icon {
    font-size: 24px;
    animation: pulse 2s infinite;
  }

  .streak-info {
    flex: 1;
  }

  .streak-days {
    font-size: 1.2rem;
    font-weight: bold;
  }

  .streak-label {
    font-size: 0.8rem;
    opacity: 0.9;
  }

  /* Section Headers */
  .section-header {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
    color: rgba(255,255,255,0.9);
    font-weight: 600;
    font-size: 0.9rem;
  }

  .section-icon {
    font-size: 16px;
  }

  /* Mission Section */
  .mission-section {
    background: #333;
    border-radius: 8px;
    padding: 16px;
    flex: 1;
  }

  .mission-content {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .mission-text {
    color: #fff;
    font-size: 0.9rem;
  }

  .mission-progress {
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .progress-bar {
    flex: 1;
    height: 6px;
    background: #555;
    border-radius: 3px;
    overflow: hidden;
  }

  .progress-fill {
    height: 100%;
    background: var(--accent-purple);
    border-radius: 3px;
    transition: width 0.3s ease;
  }

  .progress-text {
    color: rgba(255,255,255,0.7);
    font-size: 0.8rem;
  }

  /* Rank Section */
  .rank-section {
    background: #333;
    border-radius: 8px;
    padding: 16px;
  }

  .rank-content {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }

  .rank-position {
    color: #fff;
    font-size: 1.5rem;
    font-weight: bold;
  }

  .rank-total {
    color: rgba(255,255,255,0.7);
    font-size: 0.8rem;
  }

  .rank-percentile {
    color: var(--accent-purple);
    font-size: 0.9rem;
    font-weight: 600;
  }

  /* Path Section */
  .path-section {
    background: #333;
    border-radius: 8px;
    padding: 16px;
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 0;
  }

  .path-content {
    display: flex;
    flex-direction: column;
    gap: 16px;
    overflow-y: auto;
    flex: 1;
    max-height: 300px;
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
    background: #444;
    color: #fff;
    text-align: left;
    width: 100%;
  }

  .node:hover:not([aria-disabled="true"]) {
    background: #555;
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
    background: #444;
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

  @keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
  }

  /* Scrollbar styling */
  .path-content::-webkit-scrollbar {
    width: 6px;
  }

  .path-content::-webkit-scrollbar-track {
    background: #1a1a1a;
    border-radius: 3px;
  }

  .path-content::-webkit-scrollbar-thumb {
    background: #555;
    border-radius: 3px;
  }

  .path-content::-webkit-scrollbar-thumb:hover {
    background: #777;
  }

  /* mobile responsive */
  @media (max-width: 768px) {
    .learning-path {
      width: 100%;
      max-width: 350px;
      max-height: 70vh;
    }
    
    .path-content {
      max-height: 200px;
    }
  }
</style> 
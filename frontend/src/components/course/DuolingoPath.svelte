<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import type { SubTopic } from '$lib/types';

  export let subTopics: SubTopic[] = [];
  export let currentSubTopicId: string = '';
  export let completedSubTopics: string[] = [];
  export let milestoneInterval: number = 3; // Every N sub-topics becomes a milestone

  const dispatch = createEventDispatcher();

  function getNodeState(subTopic: SubTopic, index: number) {
    const isCompleted = completedSubTopics.includes(subTopic.id);
    const isCurrent = subTopic.id === currentSubTopicId;
    const isMilestone = (index + 1) % milestoneInterval === 0;
    
    if (isCompleted) return 'completed';
    if (isCurrent) return 'current';
    return 'locked';
  }

  function handleNodeClick(subTopic: SubTopic, index: number) {
    const state = getNodeState(subTopic, index);
    if (state === 'locked') {
      // Shake animation for locked nodes
      return;
    }
    
    dispatch('nodeClick', { subTopicId: subTopic.id, index });
  }

  function getNodeIcon(state: string, isMilestone: boolean) {
    if (isMilestone) return '🎁'; // Treasure chest for milestones
    if (state === 'completed') return '✓';
    if (state === 'current') return '★';
    return '☆'; // Empty star for locked
  }

  function getNodeSize(state: string) {
    return state === 'current' ? '80px' : '70px';
  }

  function getNodeColor(state: string) {
    switch (state) {
      case 'completed':
        return 'var(--accent, #B78AF0)';
      case 'current':
        return 'var(--accent, #B78AF0)';
      case 'locked':
        return '#9CA3AF';
      default:
        return '#9CA3AF';
    }
  }

  function getNodeOpacity(state: string) {
    return state === 'locked' ? '0.4' : '1';
  }

  function getNodeGlow(state: string) {
    if (state === 'current') {
      return '0 0 0 4px rgba(183, 138, 240, 0.25)';
    }
    return 'none';
  }
</script>

<div class="duolingo-path">
  <!-- Connector line -->
  <div class="connector-line"></div>
  
  <!-- Header bar -->
  <div class="header-bar">
    <h2 class="unit-title">Course Progress</h2>
    <button class="guide-btn" aria-label="Help">?</button>
  </div>
  
  <!-- Nodes container -->
  <div class="nodes-container">
    {#each subTopics as subTopic, index}
      {@const state = getNodeState(subTopic, index)}
      {@const isMilestone = (index + 1) % milestoneInterval === 0}
      {@const icon = getNodeIcon(state, isMilestone)}
      
      <div 
        class="node-wrapper"
        class:completed={state === 'completed'}
        class:current={state === 'current'}
        class:locked={state === 'locked'}
        class:milestone={isMilestone}
      >
        <button
          class="node"
          class:completed={state === 'completed'}
          class:current={state === 'current'}
          class:locked={state === 'locked'}
          class:milestone={isMilestone}
          style="
            width: {getNodeSize(state)};
            height: {getNodeSize(state)};
            background-color: {getNodeColor(state)};
            opacity: {getNodeOpacity(state)};
            box-shadow: {getNodeGlow(state)};
          "
          on:click={() => handleNodeClick(subTopic, index)}
          on:keydown={(e) => {
            if (e.key === 'Enter' || e.key === ' ') {
              e.preventDefault();
              handleNodeClick(subTopic, index);
            }
          }}
          aria-label="{subTopic.title} - {state === 'completed' ? 'Completed' : state === 'current' ? 'Current' : 'Locked'}"
          role="button"
          tabindex="0"
        >
          <span class="node-icon">{icon}</span>
        </button>
        
        <!-- Tooltip -->
        <div class="tooltip" class:visible={state === 'current'}>
          {state === 'current' ? 'Start' : state === 'completed' ? 'Completed' : 'Locked'}
        </div>
        
        <!-- Node label -->
        <div class="node-label">{subTopic.title}</div>
      </div>
    {/each}
  </div>
</div>

<style>
  .duolingo-path {
    position: relative;
    width: 110px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .connector-line {
    position: absolute;
    top: 120px; /* Below header */
    bottom: 0;
    width: 2px;
    background: rgba(183, 138, 240, 0.4);
    z-index: 0;
  }

  .header-bar {
    position: sticky;
    top: 0;
    z-index: 10;
    background: #F3F4F6;
    border-radius: 24px;
    padding: 12px 20px;
    margin-bottom: 24px;
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }

  .unit-title {
    margin: 0;
    font-size: 14px;
    font-weight: 600;
    color: #374151;
  }

  .guide-btn {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    border: none;
    background: #E5E7EB;
    color: #6B7280;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
  }

  .guide-btn:hover {
    background: #D1D5DB;
    color: #374151;
  }

  .nodes-container {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
    gap: 48px;
    align-items: center;
  }

  .node-wrapper {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
  }

  .node {
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    position: relative;
    z-index: 2;
  }

  .node.completed {
    background: var(--accent, #B78AF0) !important;
    opacity: 1 !important;
  }

  .node.current {
    background: var(--accent, #B78AF0) !important;
    opacity: 1 !important;
    transform: scale(1.1);
  }

  .node.locked {
    cursor: not-allowed;
    opacity: 0.4 !important;
  }

  .node.milestone {
    /* Special styling for milestone nodes */
  }

  .node:hover:not(.locked) {
    transform: scale(1.05);
  }

  .node:focus {
    outline: 2px solid var(--accent, #B78AF0);
    outline-offset: 2px;
  }

  .node-icon {
    font-size: 24px;
    color: white;
    line-height: 1;
  }

  .node.milestone .node-icon {
    font-size: 20px;
  }

  .tooltip {
    position: absolute;
    top: -40px;
    background: rgba(0, 0, 0, 0.9);
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    white-space: nowrap;
    opacity: 0;
    transform: translateY(-4px);
    transition: all 0.2s ease;
    pointer-events: none;
    z-index: 10;
  }

  .tooltip.visible {
    opacity: 1;
    transform: translateY(0);
  }

  .tooltip::after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border: 4px solid transparent;
    border-top-color: rgba(0, 0, 0, 0.9);
  }

  .node-label {
    font-size: 12px;
    color: #6B7280;
    text-align: center;
    max-width: 100px;
    line-height: 1.2;
    font-weight: 500;
  }

  .node-wrapper.current .node-label {
    color: var(--accent, #B78AF0);
    font-weight: 600;
  }

  .node-wrapper.completed .node-label {
    color: var(--accent, #B78AF0);
  }

  /* Shake animation for locked nodes */
  @keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-2px); }
    75% { transform: translateX(2px); }
  }

  .node.locked:active {
    animation: shake 0.3s ease-in-out;
  }

  /* Responsive adjustments */
  @media (max-width: 768px) {
    .duolingo-path {
      width: 90px;
    }
    
    .node {
      width: 60px !important;
      height: 60px !important;
    }
    
    .node.current {
      width: 70px !important;
      height: 70px !important;
    }
    
    .node-icon {
      font-size: 20px;
    }
    
    .node.milestone .node-icon {
      font-size: 16px;
    }
  }
</style> 
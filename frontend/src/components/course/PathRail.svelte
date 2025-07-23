<script lang="ts">
  import type { PathNode } from '$lib/types';

  export let nodes: PathNode[] = [];
  export let subTopicColors: Record<string, string> = {
    A: 'var(--accent-purple)',
    B: 'var(--accent-green)'
  };
  export let currentNodeId: string = '';
  export let dividerTitles: Record<string, string> = {};

  // For scroll-sync, expose a function to set current node
  export let setCurrentNode: (id: string) => void = () => {};

  function handleNodeClick(node: PathNode) {
    if (node.state === 'locked') {
      // TODO: trigger shake animation
      return;
    }
    setCurrentNode(node.id);
    const el = document.getElementById(node.id);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
  }

  function getNodeIcon(node: PathNode): string {
    if (node.special === 'chest') return '▣';
    if (node.special === 'badge') return '🛡';
    if (node.state === 'completed') return '✔';
    if (node.state === 'current') return '★';
    if (node.state === 'future') return '☆';
    if (node.state === 'locked') return '🔒';
    return '';
  }

  function getNodeColor(node: PathNode): string {
    if (node.special === 'chest' || node.special === 'badge') return '#FFD700'; // gold
    return subTopicColors[node.subTopicId] || 'var(--accent-purple)';
  }

  function getNodeSize(node: PathNode): string {
    return node.state === 'current' ? '80px' : '72px';
  }

  function getNodeGlow(node: PathNode): string {
    return node.state === 'current' ? `0 0 0 4px ${getNodeColor(node)}66` : '0 2px 4px rgba(0,0,0,.4)';
  }

  function getNodeOpacity(node: PathNode): string {
    if (node.state === 'future') return '0.4';
    if (node.state === 'locked') return '0.2';
    return '1';
  }
</script>

<div class="path-rail">
  <div class="nodes">
    {#each nodes as node, i}
      {#if dividerTitles[node.subTopicId] && (i === 0 || nodes[i-1].subTopicId !== node.subTopicId)}
        <div class="divider">
          <span class="divider-line"></span>
          <span class="divider-title">{dividerTitles[node.subTopicId]}</span>
          <span class="divider-line"></span>
        </div>
      {/if}
      <div class="node-wrap {i % 2 === 0 ? 'zig-left' : 'zig-right'}">
        <button
          class="node {node.state} {node.special || ''}"
          style="
            background: {getNodeColor(node)};
            width: {getNodeSize(node)};
            height: {getNodeSize(node)};
            box-shadow: {getNodeGlow(node)};
            opacity: {getNodeOpacity(node)};
          "
          aria-label={node.label || node.id}
          on:click={() => handleNodeClick(node)}
          disabled={node.state === 'locked'}
        >
          <span class="icon">{getNodeIcon(node)}</span>
        </button>
        {#if node.label}
          <div class="node-label">{node.label}</div>
        {/if}
      </div>
    {/each}
  </div>
</div>

<style>
.path-rail {
  position: relative;
  width: 180px;
  margin-left: 10%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding-top: 32px;
}
.nodes {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 48px;
}
.node-wrap {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  transition: transform 0.2s;
}
.zig-left {
  align-self: flex-start;
  transform: translateX(0);
}
.zig-right {
  align-self: flex-end;
  transform: translateX(40px);
}
.node {
  border-radius: 50%;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  color: #fff;
  transition: background 0.2s, box-shadow 0.2s, transform 0.2s;
  cursor: pointer;
  outline: none;
  box-shadow: 0 2px 4px rgba(0,0,0,.12);
  background: var(--accent, #B78AF0);
}
.node:hover:not(:disabled):not(.locked) {
  background: #a06be0;
  transform: scale(1.07);
}
.node.current {
  z-index: 2;
  font-size: 2.2rem;
  border: 2px solid #fff;
  outline: none;
}
.node.completed {
  filter: none;
}
.node.future {
  filter: grayscale(0.2);
  color: #fff;
}
.node.locked {
  cursor: not-allowed;
  filter: grayscale(0.5);
  color: #fff;
}
.node.chest, .node.badge {
  background: #FFD700 !important;
  color: #fff;
}
.icon {
  pointer-events: none;
  user-select: none;
}
.node-label {
  margin-top: 8px;
  font-size: 13px;
  color: #444;
  text-align: center;
  max-width: 90px;
  font-weight: 500;
}
.divider {
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 24px 0 8px 0;
  width: 100%;
}
.divider-line {
  flex: 1;
  height: 1px;
  background: #bbb;
  opacity: 0.5;
}
.divider-title {
  font-size: 13px;
  color: #888;
  font-weight: 600;
  background: #fff;
  padding: 0 8px;
  border-radius: 8px;
}
@media (max-width: 768px) {
  .path-rail {
    width: 120px;
    margin-left: 0;
  }
  .zig-right {
    transform: translateX(20px);
  }
}
</style> 
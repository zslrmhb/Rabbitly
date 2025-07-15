<script lang="ts">
  import { onMount, onDestroy, createEventDispatcher } from 'svelte';
  import cytoscape from 'cytoscape';
  import { tick } from 'svelte';
  export let roadmap: any;

  let cy: cytoscape.Core;
  let container: HTMLDivElement;
  const dispatch = createEventDispatcher();

  // Tooltip state
  let tooltip = {
    visible: false,
    x: 0,
    y: 0,
    content: ''
  };

  // Collapsed state for clusters
  let collapsed: Record<string, boolean> = {};

  function buildElements(roadmap, collapsed) {
    const elements = [];
    for (const cluster of roadmap) {
      elements.push({ data: { id: cluster.subTopicId, label: cluster.title }, classes: 'cluster' });
      if (!collapsed[cluster.subTopicId]) {
        for (const node of cluster.nodes) {
          elements.push({ data: { id: node.id, label: node.title, parent: cluster.subTopicId, type: node.type }, classes: 'node' });
          elements.push({ data: { id: `${cluster.subTopicId}-${node.id}`, source: cluster.subTopicId, target: node.id }, classes: 'edge' });
        }
      }
    }
    return elements;
  }

  function showTooltip(evt, nodeData) {
    const { x, y } = evt.renderedPosition || evt.position || { x: 0, y: 0 };
    tooltip = {
      visible: true,
      x: x + 20,
      y: y + 20,
      content: `<strong>${nodeData.label}</strong><br>Type: ${nodeData.type || 'cluster'}<br>ID: ${nodeData.id}`
    };
  }

  function hideTooltip() {
    tooltip.visible = false;
  }

  function updateGraph() {
    if (!cy) return;
    cy.elements().remove();
    cy.add(buildElements(roadmap, collapsed));
    cy.layout({ name: 'cose', animate: true, padding: 40 }).run();
  }

  function focusNodeOrCluster(id: string) {
    if (!cy) return;
    const ele = cy.getElementById(id);
    if (ele) {
      ele.select();
      ele.emit('mouseover', { target: ele });
      ele.emit('tap', { target: ele });
    }
  }

  onMount(() => {
    if (!container || !roadmap) return;
    // Initialize all clusters as expanded
    for (const cluster of roadmap) collapsed[cluster.subTopicId] = false;
    cy = cytoscape({
      container,
      elements: buildElements(roadmap, collapsed),
      style: [
        {
          selector: '.cluster',
          style: {
            'background-color': '#bbb',
            'label': 'data(label)',
            'text-valign': 'center',
            'text-halign': 'center',
            'shape': 'roundrectangle',
            'width': 120,
            'height': 40,
            'font-size': 16,
            'color': '#222',
            'font-weight': 'bold',
            'border-width': 2,
            'border-color': '#888',
            'text-outline-width': 2,
            'text-outline-color': '#bbb',
          }
        },
        {
          selector: '.node',
          style: {
            'background-color': '#eee',
            'label': 'data(label)',
            'shape': 'ellipse',
            'width': 80,
            'height': 40,
            'font-size': 14,
            'color': '#333',
            'border-width': 1,
            'border-color': '#aaa',
            'text-outline-width': 2,
            'text-outline-color': '#eee',
          }
        },
        {
          selector: '.edge',
          style: {
            'width': 2,
            'line-color': '#aaa',
            'target-arrow-shape': 'triangle',
            'target-arrow-color': '#aaa',
            'curve-style': 'bezier',
          }
        },
        {
          selector: ':selected',
          style: {
            'border-color': '#222',
            'border-width': 3,
            'background-color': '#fff',
            'color': '#000',
            'text-outline-color': '#fff',
          }
        }
      ],
      layout: {
        name: 'cose',
        animate: true,
        padding: 40
      },
      wheelSensitivity: 0.2
    });
    cy.userPanningEnabled(true);
    cy.userZoomingEnabled(true);

    // Tooltips and click events
    cy.on('mouseover', 'node', (evt) => {
      const node = evt.target;
      showTooltip(evt, node.data());
    });
    cy.on('mouseout', 'node', () => {
      hideTooltip();
    });
    cy.on('tap', 'node', (evt) => {
      const node = evt.target;
      if (node.hasClass('cluster')) {
        // Toggle cluster expand/collapse
        collapsed[node.id()] = !collapsed[node.id()];
        updateGraph();
      } else {
        dispatch('nodeClick', node.data());
      }
    });

    // Keyboard navigation
    container.addEventListener('keydown', (e) => {
      const focusables = cy.nodes().map(n => n.id());
      let idx = focusables.indexOf(document.activeElement?.getAttribute('data-cy-id') || '');
      if (e.key === 'Tab') {
        e.preventDefault();
        idx = e.shiftKey ? idx - 1 : idx + 1;
        if (idx < 0) idx = focusables.length - 1;
        if (idx >= focusables.length) idx = 0;
        const nextId = focusables[idx];
        const ele = cy.getElementById(nextId);
        if (ele) {
          ele.select();
          tick().then(() => {
            const dom = container.querySelector(`[data-cy-id="${nextId}"]`);
            if (dom) (dom as HTMLElement).focus();
          });
        }
      } else if (e.key === 'Enter' || e.key === ' ') {
        const ele = cy.getElementById(document.activeElement?.getAttribute('data-cy-id') || '');
        if (ele) {
          if (ele.hasClass('cluster')) {
            collapsed[ele.id()] = !collapsed[ele.id()];
            updateGraph();
          } else {
            dispatch('nodeClick', ele.data());
          }
        }
      }
    });
  });

  onDestroy(() => {
    if (cy) cy.destroy();
  });
</script>

<div bind:this={container} class="cy-container" tabindex="0" aria-label="Course roadmap graph" role="region"></div>

{#if tooltip.visible}
  <div class="cy-tooltip" style="left: {tooltip.x}px; top: {tooltip.y}px;" on:mouseleave={hideTooltip} tabindex="-1">
    {@html tooltip.content}
  </div>
{/if}

<style>
.cy-container {
  width: 100%;
  height: 500px;
  background: var(--grey-2, #eaeaea);
  border-radius: 1rem;
  margin-top: 2rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  outline: none;
}
.cy-tooltip {
  position: fixed;
  z-index: 1000;
  background: #222;
  color: #fff;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  font-size: 0.95rem;
  pointer-events: none;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  max-width: 240px;
}
:focus {
  outline: 2px solid #222 !important;
  outline-offset: 2px;
}
</style> 
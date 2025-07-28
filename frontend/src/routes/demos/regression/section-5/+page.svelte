<script lang="ts">
  import { onMount, tick } from 'svelte';
  import Title from '../../../../components/course/Title.svelte';
  import * as d3 from 'd3';
  import { DEBUG } from '../../../../lib/config';

  // Adjustable weights for selected connections
  let w1: number = 0.5;
  let w2: number = 1.2;
  // Map to store references to connection lines
  const connMap: Record<string, any> = {};
  let weightLabelsGroup;
  let svgContainer: HTMLDivElement;
  let svg: SVGSVGElement;
  let initialized = false;

  // Subsection state: 0 = introduction, 1 = interactive network
  let currentSubsection: number = DEBUG ? 1 : 0;

  /** Build a simple neural network diagram with input, hidden and output layers. */
  function setup() {
    const width = svgContainer.clientWidth;
    const height = 360;
    svg.setAttribute('width', String(width));
    svg.setAttribute('height', String(height));
    const g = d3.select(svg).append('g').attr('transform', `translate(50,50)`);
    // Define layer coordinates
    const layers = [
      { x: 100, neurons: [{ y: 150 }, { y: 250 }] },
      { x: 300, neurons: [{ y: 120 }, { y: 200 }, { y: 280 }] },
      { x: 500, neurons: [{ y: 200 }] }
    ];
    const connections = g.append('g').attr('class', 'connections');
    // Input to hidden
    layers[0].neurons.forEach((input, i) => {
      layers[1].neurons.forEach((hidden, j) => {
        const id = `conn-${i}-${j}`;
        const line = connections.append('line')
          .attr('x1', layers[0].x + 15)
          .attr('y1', input.y)
          .attr('x2', layers[1].x - 15)
          .attr('y2', hidden.y)
          .attr('stroke', '#9ca3af')
          .attr('stroke-width', 2);
        connMap[id] = line;
      });
    });
    // Hidden to output
    layers[1].neurons.forEach((hidden, i) => {
      layers[2].neurons.forEach((output, j) => {
        const id = `conn-h${i}-o${j}`;
        const line = connections.append('line')
          .attr('x1', layers[1].x + 15)
          .attr('y1', hidden.y)
          .attr('x2', layers[2].x - 15)
          .attr('y2', output.y)
          .attr('stroke', '#9ca3af')
          .attr('stroke-width', 2);
        connMap[id] = line;
      });
    });
    // Draw neurons and labels
    layers.forEach((layer, layerIndex) => {
      layer.neurons.forEach((neuron, neuronIndex) => {
        g.append('circle')
          .attr('cx', layer.x)
          .attr('cy', neuron.y)
          .attr('r', 15)
          .attr('fill', '#6366f1')
          .attr('stroke', 'white')
          .attr('stroke-width', 2);
        if (layerIndex === 0) {
          g.append('text')
            .attr('x', layer.x - 30)
            .attr('y', neuron.y + 4)
            .attr('text-anchor', 'middle')
            .attr('font-size', 12)
            .text(`x${neuronIndex + 1}`);
        } else if (layerIndex === 2) {
          g.append('text')
            .attr('x', layer.x + 30)
            .attr('y', neuron.y + 4)
            .attr('text-anchor', 'middle')
            .attr('font-size', 12)
            .text('y');
        }
      });
    });
    // Group for weight labels
    weightLabelsGroup = g.append('g').attr('class', 'weight-labels');
    // Layer labels
    g.append('text')
      .attr('x', 100)
      .attr('y', 300)
      .attr('text-anchor', 'middle')
      .attr('font-size', 14)
      .attr('font-weight', '600')
      .text('Input Layer');
    g.append('text')
      .attr('x', 300)
      .attr('y', 300)
      .attr('text-anchor', 'middle')
      .attr('font-size', 14)
      .attr('font-weight', '600')
      .text('Hidden Layer');
    g.append('text')
      .attr('x', 500)
      .attr('y', 300)
      .attr('text-anchor', 'middle')
      .attr('font-size', 14)
      .attr('font-weight', '600')
      .text('Output Layer');
    initialized = true;
    updateWeights();
  }

  /** Update connection colors and widths based on weights, and draw labels. */
  function updateWeights() {
    if (!initialized) return;
    connMap['conn-0-0']
      .attr('stroke-width', Math.abs(w1) * 3 + 1)
      .attr('stroke', w1 > 0 ? '#10b981' : '#ef4444');
    connMap['conn-1-0']
      .attr('stroke-width', Math.abs(w2) * 3 + 1)
      .attr('stroke', w2 > 0 ? '#10b981' : '#ef4444');
    weightLabelsGroup.selectAll('*').remove();
    weightLabelsGroup.append('text')
      .attr('x', 200)
      .attr('y', 120)
      .attr('font-size', 12)
      .attr('fill', '#374151')
      .attr('text-anchor', 'middle')
      .text(`w₁=${w1.toFixed(1)}`);
    weightLabelsGroup.append('text')
      .attr('x', 200)
      .attr('y', 280)
      .attr('font-size', 12)
      .attr('fill', '#374151')
      .attr('text-anchor', 'middle')
      .text(`w₂=${w2.toFixed(1)}`);
  }

  // Reactively update network when weights change
  $: updateWeights();

  onMount(() => {
    // If debug or starting on the interactive subsection, set up immediately
    if (currentSubsection === 1) {
      setup();
    }
  });

  /** Advance to the next subsection. On entering the interactive portion, ensure the diagram is initialized after the DOM updates. */
  async function next() {
    if (currentSubsection < 1) {
      currentSubsection = 1;
      await tick();
      setup();
    } else {
      localStorage.setItem('regression_section5_level1_complete', 'true');
      window.location.href = '/demos/regression';
    }
  }
</script>

<div class="min-h-screen bg-white px-4 py-8">
  <div class="max-w-3xl mx-auto">
    {#if currentSubsection === 0}
      <!-- Introduction subsection -->
      <Title text="Section 5: Deep Learning Perspective" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        In this final section we will see how a linear regression model can be interpreted as a simple neural
        network. A neural network is built from linear operations combined with nonlinearities. Even the simplest network
        starts with weighted connections between neurons.
      </p>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Check</button>
      </div>
    {:else}
      <!-- Interactive network subsection -->
      <Title text="Section 5: Deep Learning Perspective" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        Adjust the weights on the connections to see how they affect the diagram. Positive weights are shown in green and negative weights in red.
      </p>
      <div class="mt-6 border border-gray-200 rounded-xl shadow p-4" bind:this={svgContainer}>
        <svg bind:this={svg}></svg>
      </div>
      <div class="mt-6 flex flex-wrap justify-center gap-6">
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Weight 1</label>
          <input
            type="range"
            min="-2"
            max="2"
            step="0.1"
            bind:value={w1}
            on:input={updateWeights}
            class="range range-primary w-32"
          />
          <span class="text-sm">{w1.toFixed(1)}</span>
        </div>
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Weight 2</label>
          <input
            type="range"
            min="-2"
            max="2"
            step="0.1"
            bind:value={w2}
            on:input={updateWeights}
            class="range range-secondary w-32"
          />
          <span class="text-sm">{w2.toFixed(1)}</span>
        </div>
      </div>
      <div class="mt-6 bg-gray-50 border-l-4 border-green-500 p-4 rounded text-sm text-gray-600">
        <strong class="text-gray-700 font-semibold">Neural Network:</strong> Even simple neural networks are built from linear operations like
        regression. Each connection has a weight, and neurons combine inputs linearly. This forms the foundation of deep learning.
      </div>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Complete</button>
      </div>
    {/if}
  </div>
</div>

<style>
  /* No additional SVG axis styling needed here */
</style>
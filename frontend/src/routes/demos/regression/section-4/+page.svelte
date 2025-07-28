<script lang="ts">
  import { onMount, tick } from 'svelte';
  import Title from '../../../../components/course/Title.svelte';
  import * as d3 from 'd3';
  import { DEBUG } from '../../../../lib/config';

  // Slider value representing model complexity
  let complexity: number = 3;
  let svgContainer: HTMLDivElement;
  let svg: SVGSVGElement;
  let complexityScale;
  let errorScale;
  let complexityMarker;
  let initialized = false;

  // Subsection state: 0 = introduction, 1 = interactive bias-variance plot
  let currentSubsection: number = DEBUG ? 1 : 0;

  /** Set up the bias-variance plot with axes, lines, legend and marker. */
  function setup() {
    const width = svgContainer.clientWidth;
    const height = 320;
    svg.setAttribute('width', String(width));
    svg.setAttribute('height', String(height));
    const margin = { top: 20, right: 20, bottom: 60, left: 60 };
    const innerWidth = width - margin.left - margin.right;
    const innerHeight = height - margin.top - margin.bottom;
    const g = d3.select(svg).append('g').attr('transform', `translate(${margin.left},${margin.top})`);
    // Scales
    complexityScale = d3.scaleLinear().domain([1, 10]).range([0, innerWidth]);
    errorScale = d3.scaleLinear().domain([0, 10]).range([innerHeight, 0]);
    // Data for bias, variance and total error
    const biasData = [], varianceData = [], totalData = [];
    for (let i = 1; i <= 10; i++) {
      const bias = Math.max(0.5, 8 - i);
      const variance = Math.min(8, i * 0.8);
      biasData.push({ x: i, y: bias });
      varianceData.push({ x: i, y: variance });
      totalData.push({ x: i, y: bias + variance + 0.5 });
    }
    const line = d3.line()
      .x((d: any) => complexityScale(d.x))
      .y((d: any) => errorScale(d.y))
      .curve(d3.curveMonotoneX);
    // Axes
    g.append('g')
      .attr('class', 'axis')
      .attr('transform', `translate(0,${innerHeight})`)
      .call(d3.axisBottom(complexityScale).tickFormat((d) => `${d}`));
    g.append('g').attr('class', 'axis').call(d3.axisLeft(errorScale));
    // Axis labels
    g.append('text')
      .attr('x', innerWidth / 2)
      .attr('y', innerHeight + 40)
      .attr('text-anchor', 'middle')
      .attr('font-size', 14)
      .text('Model Complexity');
    g.append('text')
      .attr('transform', 'rotate(-90)')
      .attr('x', -innerHeight / 2)
      .attr('y', -40)
      .attr('text-anchor', 'middle')
      .attr('font-size', 14)
      .text('Error');
    // Lines
    g.append('path').datum(biasData).attr('d', line).attr('fill', 'none').attr('stroke', '#ef4444').attr('stroke-width', 3);
    g.append('path').datum(varianceData).attr('d', line).attr('fill', 'none').attr('stroke', '#2dd4bf').attr('stroke-width', 3);
    g.append('path').datum(totalData).attr('d', line).attr('fill', 'none').attr('stroke', '#374151').attr('stroke-width', 3).attr('stroke-dasharray', '5,5');
    // Legend
    const legend = g.append('g').attr('transform', `translate(${innerWidth - 120},20)`);
    legend.append('line').attr('x1', 0).attr('x2', 20).attr('y1', 0).attr('y2', 0).attr('stroke', '#ef4444').attr('stroke-width', 3);
    legend.append('text').attr('x', 25).attr('y', 4).attr('font-size', 12).text('Bias');
    legend.append('line').attr('x1', 0).attr('x2', 20).attr('y1', 20).attr('y2', 20).attr('stroke', '#2dd4bf').attr('stroke-width', 3);
    legend.append('text').attr('x', 25).attr('y', 24).attr('font-size', 12).text('Variance');
    legend.append('line').attr('x1', 0).attr('x2', 20).attr('y1', 40).attr('y2', 40).attr('stroke', '#374151').attr('stroke-width', 3).attr('stroke-dasharray', '5,5');
    legend.append('text').attr('x', 25).attr('y', 44).attr('font-size', 12).text('Total Error');
    // Marker
    complexityMarker = g.append('line')
      .attr('stroke', '#10b981')
      .attr('stroke-width', 3)
      .attr('y1', 0)
      .attr('y2', innerHeight);
    initialized = true;
    updateMarker();
  }

  /** Position the vertical marker based on the current complexity. */
  function updateMarker() {
    if (!initialized) return;
    const xPos = complexityScale(complexity);
    complexityMarker.attr('x1', xPos).attr('x2', xPos);
  }

  // Update marker whenever complexity changes
  $: updateMarker();

  /** Advance to the next subsection. When entering the interactive part, wait for the DOM to update and build the D3 plot. On completion, mark completion and navigate on. */
  async function next() {
    if (currentSubsection < 1) {
      currentSubsection = 1;
      await tick();
      setup();
    } else {
      localStorage.setItem('regression_section4_level1_complete', 'true');
      window.location.href = '/demos/regression/section-5';
    }
  }

  onMount(() => {
    // Only initialize if starting on the interactive subsection
    if (currentSubsection === 1) {
      setup();
    }
  });
</script>

<div class="min-h-screen bg-white px-4 py-8">
  <div class="max-w-3xl mx-auto">
    {#if currentSubsection === 0}
      <!-- Introduction subsection -->
      <Title text="Section 4: Generalization" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        In this section, we study how a model performs on unseen data. The bias–variance tradeoff explains why models
        that are too simple or too complex can perform poorly.
      </p>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Check</button>
      </div>
    {:else}
      <!-- Interactive subsection -->
      <Title text="Section 4: Generalization" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        Adjust the model complexity slider to see how bias, variance and total error change. Find a balance that
        minimizes the total error.
      </p>
      <div class="mt-6 border border-gray-200 rounded-xl shadow p-4" bind:this={svgContainer}>
        <svg bind:this={svg}></svg>
      </div>
      <div class="mt-6 flex justify-center gap-6">
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Model Complexity</label>
          <input
            type="range"
            min="1"
            max="10"
            step="1"
            bind:value={complexity}
            on:input={updateMarker}
            class="range range-primary w-48"
          />
          <span class="text-sm">{complexity}</span>
        </div>
      </div>
      <div class="mt-6 bg-gray-50 border-l-4 border-green-500 p-4 rounded text-sm text-gray-600">
        <strong class="text-gray-700 font-semibold">Bias–Variance Tradeoff:</strong> Simple models (low complexity) may
        underfit, while complex models may overfit. The best model balances bias and variance to minimize total error.
      </div>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Continue</button>
      </div>
    {/if}
  </div>
</div>

<style>
  svg .axis text {
    fill: #4b5563;
    font-size: 12px;
  }
  svg .axis path,
  svg .axis line {
    stroke: #9ca3af;
    shape-rendering: crispEdges;
  }
</style>
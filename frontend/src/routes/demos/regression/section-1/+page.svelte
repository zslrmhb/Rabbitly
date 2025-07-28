<script lang="ts">
  import { onMount, tick } from 'svelte';
  import Title from '../../../../components/course/Title.svelte';
  import * as d3 from 'd3';
  import { DEBUG } from '../../../../lib/config';

  // Interactive parameters for the linear equation y = w*x + b
  let weight: number = 1;
  let bias: number = 0;

  // References for the D3 chart
  let svgContainer: HTMLDivElement;
  let svg: SVGSVGElement;
  let line;
  let xScale;
  let yScale;
  let initialized = false;

  // Subsection state: 0 = introduction, 1 = interactive sliders
  let currentSubsection: number = DEBUG ? 1 : 0;

  /**
   * Build the axes, grid and regression line. This runs on mount and whenever the
   * container size changes.
   */
  function setup() {
    const width = svgContainer.clientWidth;
    const height = 360;
    svg.setAttribute('width', String(width));
    svg.setAttribute('height', String(height));
    const margin = { top: 20, right: 20, bottom: 40, left: 40 };
    const innerWidth = width - margin.left - margin.right;
    const innerHeight = height - margin.top - margin.bottom;
    const g = d3
      .select(svg)
      .append('g')
      .attr('transform', `translate(${margin.left},${margin.top})`);
    // Scales
    xScale = d3.scaleLinear().domain([-10, 10]).range([0, innerWidth]);
    yScale = d3.scaleLinear().domain([-15, 15]).range([innerHeight, 0]);
    // Grid
    g.selectAll('.grid-x')
      .data(xScale.ticks(10))
      .enter()
      .append('line')
      .attr('class', 'grid-x')
      .attr('x1', (d) => xScale(d))
      .attr('x2', (d) => xScale(d))
      .attr('y1', 0)
      .attr('y2', innerHeight)
      .attr('stroke', '#e5e5e5')
      .attr('stroke-width', 0.5);
    g.selectAll('.grid-y')
      .data(yScale.ticks(10))
      .enter()
      .append('line')
      .attr('class', 'grid-y')
      .attr('x1', 0)
      .attr('x2', innerWidth)
      .attr('y1', (d) => yScale(d))
      .attr('y2', (d) => yScale(d))
      .attr('stroke', '#e5e5e5')
      .attr('stroke-width', 0.5);
    // Axes
    g.append('g')
      .attr('class', 'axis')
      .attr('transform', `translate(0,${innerHeight})`)
      .call(d3.axisBottom(xScale));
    g.append('g').attr('class', 'axis').call(d3.axisLeft(yScale));
    // Regression line
    line = g.append('line').attr('stroke', '#ef4444').attr('stroke-width', 3);
    initialized = true;
    updateLine();
  }

  /**
   * Draw the regression line using the current weight and bias.
   */
  function updateLine() {
    if (!initialized) return;
    const w = +weight;
    const b = +bias;
    const x1 = -10;
    const x2 = 10;
    const y1 = w * x1 + b;
    const y2 = w * x2 + b;
    line
      .attr('x1', xScale(x1))
      .attr('y1', yScale(y1))
      .attr('x2', xScale(x2))
      .attr('y2', yScale(y2));
  }

  // Recompute the line whenever parameters change
  $: updateLine();

  onMount(() => {
    // Only initialize the chart immediately if starting on the interactive subsection
    if (currentSubsection === 1) {
      setup();
    }
    const handleResize = () => {
      if (currentSubsection === 1) {
        if (svg) {
          while (svg.firstChild) {
            svg.removeChild(svg.firstChild);
          }
        }
        setup();
      }
    };
    window.addEventListener('resize', handleResize);
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  });

  /**
   * Advance to the next subsection. When entering the interactive part,
   * wait for DOM update and build the D3 chart. When finished,
   * mark completion and navigate to the next section.
   */
  async function next() {
    if (currentSubsection < 1) {
      currentSubsection = 1;
      await tick();
      setup();
    } else {
      localStorage.setItem('regression_section1_level1_complete', 'true');
      window.location.href = '/demos/regression/section-2';
    }
  }
</script>

<div class="min-h-screen bg-white px-4 py-8">
  <div class="max-w-3xl mx-auto">
    {#if currentSubsection === 0}
      <!-- Introduction subsection -->
      <Title text="Section 1: Regression Problem & Model" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        In this first section we introduce the linear model <em>y = wx + b</em>.  The weight (<em>w</em>) controls the slope and the bias (<em>b</em>) shifts the line.
        You will explore how changing these parameters affects the line.
      </p>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Check</button>
      </div>
    {:else}
      <!-- Interactive subsection -->
      <Title text="Section 1: Regression Problem & Model" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        Adjust the sliders to see how weight and bias change the line. When you are ready, click Continue to move on.
      </p>
      <div class="bg-gray-50 border border-gray-200 rounded-xl p-4 text-center mt-6 text-xl font-semibold">
        y = <span class="text-red-500">{weight.toFixed(1)}</span>x + <span class="text-teal-500">{bias.toFixed(1)}</span>
      </div>
      <div class="mt-6 flex flex-wrap justify-center gap-6">
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Weight (w)</label>
          <input
            type="range"
            min="-3"
            max="3"
            step="0.1"
            bind:value={weight}
            on:input={updateLine}
            class="range range-primary w-40"
          />
          <span class="text-sm">{weight.toFixed(1)}</span>
        </div>
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Bias (b)</label>
          <input
            type="range"
            min="-5"
            max="5"
            step="0.1"
            bind:value={bias}
            on:input={updateLine}
            class="range range-secondary w-40"
          />
          <span class="text-sm">{bias.toFixed(1)}</span>
        </div>
      </div>
      <div class="mt-6 border border-gray-200 rounded-xl shadow p-4" bind:this={svgContainer}>
        <svg bind:this={svg}></svg>
      </div>
      <div class="mt-6 bg-gray-50 border-l-4 border-green-500 p-4 rounded text-sm text-gray-600">
        <strong class="text-gray-700 font-semibold">Linear Equation:</strong> The equation <code>y = wx + b</code> represents a straight line.
        Adjust the sliders above to explore how the slope and intercept affect the line.
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
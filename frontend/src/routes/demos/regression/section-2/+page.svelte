<script lang="ts">
  import { onMount, tick } from 'svelte';
  import Title from '../../../../components/course/Title.svelte';
  import { DEBUG } from '../../../../lib/config';
  import * as d3 from 'd3';

  // Dataset to visualize the line of best fit
  const sampleData = [
    { x: 1, y: 2.1 },
    { x: 2, y: 3.9 },
    { x: 3, y: 6.2 },
    { x: 4, y: 8.1 },
    { x: 5, y: 9.8 },
    { x: 6, y: 12.2 },
    { x: 7, y: 14.1 },
    { x: 8, y: 15.9 },
    { x: 9, y: 18.2 },
    { x: 10, y: 20.1 }
  ];

  // Parameters for the regression line
  let weight: number = 1.5;
  let bias: number = 1.0;
  let mse: number = 0;

  // Subsection state: 0 = introduction, 1 = interactive demonstration
  let currentSubsection: number = DEBUG ? 1 : 0;

  // D3 references and state
  let svgContainer: HTMLDivElement;
  let svg: SVGSVGElement;
  let xScale;
  let yScale;
  let line;
  let errorGroup;
  let initialized = false;

  /**
   * Initialize the scatterplot: grid, axes, data points, regression line.
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
    xScale = d3.scaleLinear().domain([0, 11]).range([0, innerWidth]);
    yScale = d3.scaleLinear().domain([0, 25]).range([innerHeight, 0]);
    // Grid
    g.selectAll('.grid-x')
      .data(xScale.ticks(11))
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
    // Data points
    g.selectAll('.point')
      .data(sampleData)
      .enter()
      .append('circle')
      .attr('class', 'point')
      .attr('cx', (d) => xScale(d.x))
      .attr('cy', (d) => yScale(d.y))
      .attr('r', 4)
      .attr('fill', '#22c55e')
      .attr('stroke', 'white')
      .attr('stroke-width', 1.5);
    // Regression line
    line = g
      .append('line')
      .attr('stroke', '#ef4444')
      .attr('stroke-width', 3);
    // Error lines group
    errorGroup = g.append('g');
    initialized = true;
    updateChart();
  }

  /**
   * Compute and draw the regression line and error bars; update MSE.
   */
  function updateChart() {
    if (!initialized) return;
    const w = +weight;
    const b = +bias;
    // Endpoints for the line
    const x1 = 0;
    const x2 = 11;
    const y1 = w * x1 + b;
    const y2 = w * x2 + b;
    line
      .attr('x1', xScale(x1))
      .attr('y1', yScale(y1))
      .attr('x2', xScale(x2))
      .attr('y2', yScale(y2));
    // Errors
    let totalLoss = 0;
    errorGroup.selectAll('*').remove();
    sampleData.forEach((d) => {
      const predicted = w * d.x + b;
      const error = d.y - predicted;
      totalLoss += error * error;
      errorGroup
        .append('line')
        .attr('x1', xScale(d.x))
        .attr('y1', yScale(d.y))
        .attr('x2', xScale(d.x))
        .attr('y2', yScale(predicted))
        .attr('stroke', '#ef4444')
        .attr('stroke-width', 1)
        .attr('stroke-dasharray', '3,3');
    });
    mse = totalLoss / sampleData.length;
  }

  // Update chart whenever weight or bias changes
  $: updateChart();

  /**
   * Advance to the next subsection. When entering the interactive part,
   * wait for the DOM to update and build the D3 chart. When completing
   * the interactive part, record completion in localStorage and navigate
   * to the next section.
   */
  async function next() {
    if (currentSubsection < 1) {
      currentSubsection = 1;
      await tick();
      setup();
    } else {
      // Mark this section as complete and move to the next section
      localStorage.setItem('regression_section2_level1_complete', 'true');
      window.location.href = '/demos/regression/section-3';
    }
  }

  onMount(() => {
    // Only initialize the chart immediately if we start on the interactive subsection
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
</script>

<!-- White background wrapper with centered content -->
<div class="min-h-screen bg-white px-4 py-8">
  <div class="max-w-3xl mx-auto">
    {#if currentSubsection === 0}
      <!-- Introduction subsection -->
      <Title text="Section 2: Training – Analytic Solution" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        In this section, we'll explore how to find the best line for a set of data points using the analytic least squares solution.
      </p>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Check</button>
      </div>
    {:else}
      <!-- Interactive subsection -->
      <Title text="Section 2: Training – Analytic Solution" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        Adjust the sliders to see how weight and bias affect the fitted line. Try to minimize the loss.
      </p>
      <!-- Chart container -->
      <div class="mt-6 border border-gray-200 rounded-xl shadow p-4" bind:this={svgContainer}>
        <svg bind:this={svg}></svg>
      </div>
      <!-- Controls -->
      <div class="mt-6 flex flex-wrap justify-center gap-6">
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Weight (w)</label>
          <input
            type="range"
            min="-2"
            max="4"
            step="0.1"
            bind:value={weight}
            on:input={updateChart}
            class="range range-primary w-40"
          />
          <span class="text-sm">{weight.toFixed(1)}</span>
        </div>
        <div class="flex flex-col items-center gap-1">
          <label class="font-semibold text-sm text-gray-700">Bias (b)</label>
          <input
            type="range"
            min="-3"
            max="3"
            step="0.1"
            bind:value={bias}
            on:input={updateChart}
            class="range range-secondary w-40"
          />
          <span class="text-sm">{bias.toFixed(1)}</span>
        </div>
      </div>
      <!-- Loss display -->
      <div class="mt-6 bg-gray-50 border border-gray-200 rounded-xl p-4 text-center text-xl font-semibold">
        Loss = <span class="text-red-500">{mse.toFixed(2)}</span>
      </div>
      <!-- Explanation -->
      <div class="mt-6 bg-gray-50 border-l-4 border-green-500 p-4 rounded text-sm text-gray-600">
        <strong class="text-gray-700 font-semibold">Line of Best Fit:</strong> To find the best line, we choose the weight and bias that minimize the total squared error between the predicted and actual points. Experiment with the sliders to observe how the loss changes.
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
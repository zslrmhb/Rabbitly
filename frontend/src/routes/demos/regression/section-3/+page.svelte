<script lang="ts">
  import { onMount, tick } from 'svelte';
  import Title from '../../../../components/course/Title.svelte';
  import * as d3 from 'd3';
  import { DEBUG } from '../../../../lib/config';

  // Sample data for gradient descent demonstration
  const sampleData = [
    { x: 1, y: 2.1 }, { x: 2, y: 3.9 }, { x: 3, y: 6.2 }, { x: 4, y: 8.1 }, { x: 5, y: 9.8 },
    { x: 6, y: 12.2 }, { x: 7, y: 14.1 }, { x: 8, y: 15.9 }, { x: 9, y: 18.2 }, { x: 10, y: 20.1 }
  ];

  let currentW: number = -1;
  let currentB: number = 3;
  const learningRate: number = 0.1;
  let wScale;
  let lossScale;
  let marker;
  let svgContainer: HTMLDivElement;
  let svg: SVGSVGElement;
  let initialized = false;

  // Subsection state: 0 = introduction, 1 = interactive gradient descent
  let currentSubsection: number = DEBUG ? 1 : 0;

  /** Compute the mean squared error for a weight and bias. */
  function computeLoss(w: number, b: number): number {
    let sum = 0;
    sampleData.forEach((d) => {
      const pred = w * d.x + b;
      sum += (d.y - pred) ** 2;
    });
    return sum / sampleData.length;
  }

  /** Draw the loss surface and marker. */
  function setup() {
    const width = svgContainer.clientWidth;
    const height = 300;
    svg.setAttribute('width', String(width));
    svg.setAttribute('height', String(height));
    const margin = { top: 20, right: 20, bottom: 40, left: 40 };
    const innerWidth = width - margin.left - margin.right;
    const innerHeight = height - margin.top - margin.bottom;
    const g = d3.select(svg).append('g').attr('transform', `translate(${margin.left},${margin.top})`);
    // Scales
    wScale = d3.scaleLinear().domain([-2, 4]).range([0, innerWidth]);
    lossScale = d3.scaleLinear().domain([0, 50]).range([innerHeight, 0]);
    // Precompute loss values for weights with bias fixed at 1.8
    const lossData = [];
    for (let w = -2; w <= 4; w += 0.1) {
      let sum = 0;
      sampleData.forEach((d) => {
        const pred = w * d.x + 1.8;
        sum += (d.y - pred) ** 2;
      });
      lossData.push({ w, loss: sum / sampleData.length });
    }
    const line = d3.line().x((d: any) => wScale(d.w)).y((d: any) => lossScale(d.loss));
    g.append('path')
      .datum(lossData)
      .attr('d', line)
      .attr('fill', 'none')
      .attr('stroke', '#e5e5e5')
      .attr('stroke-width', 2);
    // Axes
    g.append('g')
      .attr('class', 'axis')
      .attr('transform', `translate(0,${innerHeight})`)
      .call(d3.axisBottom(wScale).tickFormat((d) => `w=${d}`));
    g.append('g').attr('class', 'axis').call(d3.axisLeft(lossScale));
    // Marker
    marker = g.append('circle')
      .attr('r', 8)
      .attr('fill', '#ef4444')
      .attr('stroke', 'white')
      .attr('stroke-width', 2);
    initialized = true;
    updateMarker();
  }

  /** Update the marker location based on current parameters. */
  function updateMarker() {
    if (!initialized) return;
    const loss = computeLoss(currentW, currentB);
    marker.attr('cx', wScale(currentW)).attr('cy', lossScale(loss));
  }

  /** Perform one gradient descent step on the weight parameter only. */
  function step() {
    let grad = 0;
    sampleData.forEach((d) => {
      const pred = currentW * d.x + currentB;
      grad += -2 * (d.y - pred) * d.x;
    });
    grad = grad / sampleData.length;
    currentW -= learningRate * grad;
    updateMarker();
  }

  /** Reset parameters to starting values. */
  function reset() {
    currentW = -1;
    currentB = 3;
    updateMarker();
  }

  /** Advance to the next subsection. When entering the interactive part, wait for the DOM to update and build the D3 visualization. On completion, record completion in localStorage and navigate onward. */
  async function next() {
    if (currentSubsection < 1) {
      currentSubsection = 1;
      await tick();
      setup();
    } else {
      localStorage.setItem('regression_section3_level1_complete', 'true');
      window.location.href = '/demos/regression/section-4';
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
      <Title text="Section 3: Training – Gradient Descent" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        In this section, you'll learn why gradient descent is useful when the analytic solution is impractical. We'll explore how following the slope of the loss function leads to better weights.
      </p>
      <div class="mt-8 flex justify-center">
        <button class="btn btn-primary" on:click={next}>Check</button>
      </div>
    {:else}
      <!-- Interactive subsection -->
      <Title text="Section 3: Training – Gradient Descent" level={2} />
      <p class="mt-2 text-gray-600 text-sm">
        Click "Take Gradient Step" to follow the gradient and update the weight. Observe how the marker moves down the loss curve toward the minimum.
      </p>
      <div class="mt-6 border border-gray-200 rounded-xl shadow p-4" bind:this={svgContainer}>
        <svg bind:this={svg}></svg>
      </div>
      <div class="mt-6 flex justify-center gap-4">
        <button class="btn btn-primary" on:click={step}>Take Gradient Step</button>
        <button class="btn btn-secondary" on:click={reset}>Reset</button>
      </div>
      <div class="mt-6 bg-gray-50 border-l-4 border-green-500 p-4 rounded text-sm text-gray-600">
        <strong class="text-gray-700 font-semibold">Gradient Descent:</strong> We find the optimal parameters by following the gradient of the loss function. Each step moves us closer to the minimum.
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
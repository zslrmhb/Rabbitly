<script lang="ts">
	import { onMount, createEventDispatcher } from 'svelte';
	import * as d3 from 'd3';

	// Graph type definitions
	type GraphType = 'regression' | 'scatter' | 'line' | 'bar' | 'area';
	type DataPoint = { x: number; y: number; label?: string; color?: string };
	type GraphConfig = {
		type: GraphType;
		title?: string;
		xLabel?: string;
		yLabel?: string;
		showGrid?: boolean;
		showAxes?: boolean;
		showLegend?: boolean;
		interactive?: boolean;
		colors?: string[];
		lineConfig?: {
			strokeWidth?: number;
			strokeColor?: string;
			dashArray?: string;
		};
		pointConfig?: {
			radius?: number;
			fillColor?: string;
			strokeColor?: string;
			strokeWidth?: number;
		};
		barConfig?: {
			width?: number;
			fillColor?: string;
			strokeColor?: string;
			strokeWidth?: number;
		};
		areaConfig?: {
			fillColor?: string;
			opacity?: number;
		};
	};

	export let data: DataPoint[] = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 5 },
		{ x: 4, y: 4 },
		{ x: 5, y: 6 },
		{ x: 6, y: 7 },
		{ x: 7, y: 8 },
		{ x: 8, y: 9 }
	];

	export let config: GraphConfig = {
		type: 'regression',
		title: 'Interactive Graph',
		xLabel: 'X Axis',
		yLabel: 'Y Axis',
		showGrid: true,
		showAxes: true,
		showLegend: false,
		interactive: true,
		colors: ['#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6'],
		lineConfig: {
			strokeWidth: 3,
			strokeColor: '#ef4444',
			dashArray: 'none'
		},
		pointConfig: {
			radius: 5,
			fillColor: '#3b82f6',
			strokeColor: 'white',
			strokeWidth: 2
		},
		barConfig: {
			width: 20,
			fillColor: '#3b82f6',
			strokeColor: 'white',
			strokeWidth: 1
		},
		areaConfig: {
			fillColor: '#3b82f6',
			opacity: 0.3
		}
	};

	export let width = 600;
	export let height = 400;
	export let margin = { top: 40, right: 40, bottom: 60, left: 60 };

	const dispatch = createEventDispatcher();

	let svg: SVGSVGElement;
	let isDragging = false;
	let dragStartX = 0;
	let dragStartY = 0;
	let originalSlope = 0;
	let originalIntercept = 0;
	let dragMode: 'move' | 'rotate' = 'move';

	// Line parameters for regression
	let slope = 1;
	let intercept = 0;

	// Computed values
	$: chartWidth = width - margin.left - margin.right;
	$: chartHeight = height - margin.top - margin.bottom;

	// Scales
	$: xScale = d3
		.scaleLinear()
		.domain([0, d3.max(data, (d: DataPoint) => d.x) || 10])
		.range([0, chartWidth]);

	$: yScale = d3
		.scaleLinear()
		.domain([0, d3.max(data, (d: DataPoint) => d.y) || 10])
		.range([chartHeight, 0]);

	// Line generator for regression
	$: lineGenerator = d3
		.line<DataPoint>()
		.x((d: DataPoint) => xScale(d.x))
		.y((d: DataPoint) => yScale(slope * d.x + intercept));

	// Generate line data for regression
	$: lineData = Array.from({ length: 11 }, (_, i) => ({
		x: i,
		y: slope * i + intercept
	}));

	// Equation string
	$: equation = `y = ${slope.toFixed(2)}x + ${intercept.toFixed(2)}`;

	// R-squared calculation
	$: rSquared = calculateRSquared();

	function calculateRegressionLine() {
		const n = data.length;
		const sumX = data.reduce((sum, d) => sum + d.x, 0);
		const sumY = data.reduce((sum, d) => sum + d.y, 0);
		const sumXY = data.reduce((sum, d) => sum + d.x * d.y, 0);
		const sumXX = data.reduce((sum, d) => sum + d.x * d.x, 0);

		const calculatedSlope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
		const calculatedIntercept = (sumY - calculatedSlope * sumX) / n;

		slope = calculatedSlope;
		intercept = calculatedIntercept;
	}

	function calculateRSquared(): number {
		if (data.length === 0) return 0;
		const meanY = data.reduce((sum, d) => sum + d.y, 0) / data.length;
		const ssRes = data.reduce((sum, d) => {
			const predicted = slope * d.x + intercept;
			return sum + Math.pow(d.y - predicted, 2);
		}, 0);
		const ssTot = data.reduce((sum, d) => sum + Math.pow(d.y - meanY, 2), 0);
		return ssTot === 0 ? 1 : 1 - ssRes / ssTot;
	}

	function handleMouseDown(event: MouseEvent) {
		if (!config.interactive || config.type !== 'regression') return;
		isDragging = true;
		dragStartX = event.clientX;
		dragStartY = event.clientY;
		originalSlope = slope;
		originalIntercept = intercept;
		svg.style.cursor = 'grabbing';
	}

	function handleMouseMove(event: MouseEvent) {
		if (!isDragging || !config.interactive || config.type !== 'regression') return;

		const deltaX = event.clientX - dragStartX;
		const deltaY = event.clientY - dragStartY;

		if (dragMode === 'move') {
			const deltaYScale = deltaY / chartHeight;
			const yRange = yScale.domain()[1] - yScale.domain()[0];
			const deltaYValue = deltaYScale * yRange;
			intercept = originalIntercept - deltaYValue;
		} else if (dragMode === 'rotate') {
			const deltaXScale = deltaX / chartWidth;
			const xRange = xScale.domain()[1] - xScale.domain()[0];
			const deltaXValue = deltaXScale * xRange;
			const deltaSlope = deltaXValue * 0.1;
			slope = originalSlope + deltaSlope;
		}
	}

	function handleMouseUp() {
		isDragging = false;
		svg.style.cursor = 'grab';
	}

	function toggleDragMode() {
		dragMode = dragMode === 'move' ? 'rotate' : 'move';
	}

	function resetToRegression() {
		calculateRegressionLine();
	}

	onMount(() => {
		if (config.type === 'regression') {
			calculateRegressionLine();
		}

		if (config.interactive) {
			svg.addEventListener('mousedown', handleMouseDown);
			document.addEventListener('mousemove', handleMouseMove);
			document.addEventListener('mouseup', handleMouseUp);
		}

		return () => {
			document.removeEventListener('mousemove', handleMouseMove);
			document.removeEventListener('mouseup', handleMouseUp);
		};
	});
</script>

<div class="graph-container">
	{#if config.title}
		<div class="graph-title">{config.title}</div>
	{/if}

	{#if config.type === 'regression' && config.interactive}
		<div class="controls">
			<div class="equation-display">
				<strong>Current Line:</strong> {equation}
				<br />
				<strong>R²:</strong> {rSquared.toFixed(3)}
			</div>
			
			<div class="action-buttons">
				<button class="btn btn-secondary" on:click={resetToRegression}>
					Reset to Best Fit
				</button>
				<button class="btn btn-info" on:click={toggleDragMode}>
					Mode: {dragMode === 'move' ? 'Move' : 'Rotate'}
				</button>
			</div>
		</div>
	{/if}

	<div class="graph-wrapper">
		<svg
			bind:this={svg}
			{width}
			{height}
			class="graph"
			style="cursor: {config.interactive ? 'grab' : 'default'};"
		>
			<g transform="translate({margin.left}, {margin.top})">
				<!-- Grid lines -->
				{#if config.showGrid}
					<g class="grid">
						{#each Array.from({ length: 11 }, (_, i) => i) as i}
							<line
								x1={xScale(i)}
								y1="0"
								x2={xScale(i)}
								y2={chartHeight}
								class="grid-line"
							/>
							<line
								x1="0"
								y1={yScale(i)}
								x2={chartWidth}
								y2={yScale(i)}
								class="grid-line"
							/>
						{/each}
					</g>
				{/if}

				<!-- Axes -->
				{#if config.showAxes}
					<g class="axis">
						<line
							x1="0"
							y1="0"
							x2="0"
							y2={chartHeight}
							class="axis-line"
						/>
						<line
							x1="0"
							y1={chartHeight}
							x2={chartWidth}
							y2={chartHeight}
							class="axis-line"
						/>
					</g>
				{/if}

				<!-- Axis labels -->
				{#if config.showAxes}
					<g class="axis-labels">
						{#each Array.from({ length: 11 }, (_, i) => i) as i}
							<text
								x={xScale(i)}
								y={chartHeight + 20}
								class="axis-label"
								text-anchor="middle"
							>
								{i}
							</text>
							<text
								x="-10"
								y={yScale(i)}
								class="axis-label"
								text-anchor="end"
								dominant-baseline="middle"
							>
								{i}
							</text>
						{/each}
					</g>
				{/if}

				<!-- Graph content based on type -->
				{#if config.type === 'scatter'}
					<!-- Scatter plot -->
					{#each data as point, index}
						<circle
							cx={xScale(point.x)}
							cy={yScale(point.y)}
							r={config.pointConfig?.radius || 5}
							class="data-point"
							fill={point.color || config.pointConfig?.fillColor || config.colors?.[index % config.colors.length]}
							stroke={config.pointConfig?.strokeColor || 'white'}
							stroke-width={config.pointConfig?.strokeWidth || 2}
						/>
					{/each}
				{:else if config.type === 'line'}
					<!-- Line chart -->
					<path
						d={d3.line<DataPoint>()
							.x((d: DataPoint) => xScale(d.x))
							.y((d: DataPoint) => yScale(d.y))
							(data)}
						class="line-chart"
						stroke={config.lineConfig?.strokeColor || config.colors?.[0]}
						stroke-width={config.lineConfig?.strokeWidth || 3}
						fill="none"
						stroke-linecap="round"
						stroke-linejoin="round"
						stroke-dasharray={config.lineConfig?.dashArray || 'none'}
					/>
					{#each data as point, index}
						<circle
							cx={xScale(point.x)}
							cy={yScale(point.y)}
							r={config.pointConfig?.radius || 4}
							class="data-point"
							fill={point.color || config.pointConfig?.fillColor || config.colors?.[index % config.colors.length]}
							stroke={config.pointConfig?.strokeColor || 'white'}
							stroke-width={config.pointConfig?.strokeWidth || 2}
						/>
					{/each}
				{:else if config.type === 'bar'}
					<!-- Bar chart -->
					{#each data as point, index}
						<rect
							x={xScale(point.x) - (config.barConfig?.width || 20) / 2}
							y={yScale(point.y)}
							width={config.barConfig?.width || 20}
							height={chartHeight - yScale(point.y)}
							class="bar"
							fill={point.color || config.barConfig?.fillColor || config.colors?.[index % config.colors.length]}
							stroke={config.barConfig?.strokeColor || 'white'}
							stroke-width={config.barConfig?.strokeWidth || 1}
						/>
					{/each}
				{:else if config.type === 'area'}
					<!-- Area chart -->
					<path
						d={d3.area<DataPoint>()
							.x((d: DataPoint) => xScale(d.x))
							.y0(chartHeight)
							.y1((d: DataPoint) => yScale(d.y))
							(data)}
						class="area-chart"
						fill={config.areaConfig?.fillColor || config.colors?.[0]}
						opacity={config.areaConfig?.opacity || 0.3}
					/>
					<path
						d={d3.line<DataPoint>()
							.x((d: DataPoint) => xScale(d.x))
							.y((d: DataPoint) => yScale(d.y))
							(data)}
						class="area-line"
						stroke={config.lineConfig?.strokeColor || config.colors?.[0]}
						stroke-width={config.lineConfig?.strokeWidth || 2}
						fill="none"
					/>
				{:else if config.type === 'regression'}
					<!-- Regression line -->
					{#each data as point, index}
						<circle
							cx={xScale(point.x)}
							cy={yScale(point.y)}
							r={config.pointConfig?.radius || 5}
							class="data-point"
							fill={point.color || config.pointConfig?.fillColor || config.colors?.[index % config.colors.length]}
							stroke={config.pointConfig?.strokeColor || 'white'}
							stroke-width={config.pointConfig?.strokeWidth || 2}
						/>
					{/each}
					<path
						d={lineGenerator(lineData)}
						class="regression-line"
						stroke={config.lineConfig?.strokeColor || '#ef4444'}
						stroke-width={config.lineConfig?.strokeWidth || 3}
						fill="none"
						stroke-linecap="round"
						stroke-linejoin="round"
					/>
				{/if}

				<!-- Drag handle for interactive graphs -->
				{#if config.interactive && config.type === 'regression'}
					<rect
						x="0"
						y="0"
						width={chartWidth}
						height={chartHeight}
						class="drag-area"
						fill="transparent"
					/>
				{/if}
			</g>
		</svg>
	</div>

	{#if config.interactive && config.type === 'regression'}
		<div class="instructions">
			<p><strong>Instructions:</strong></p>
			<ul>
				<li>Drag anywhere on the graph to adjust the line</li>
				<li>Toggle between "Move" and "Rotate" modes to adjust intercept or slope</li>
				<li>Click "Reset to Best Fit" to return to the calculated regression line</li>
				<li>R² value shows how well the line fits the data (1.0 = perfect fit)</li>
			</ul>
		</div>
	{/if}
</div>

<style>
	.graph-container {
		max-width: 800px;
		margin: 2rem auto;
		padding: 1rem;
		background: white;
		border-radius: 12px;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}

	.graph-title {
		font-size: 1.5rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 1rem;
		text-align: center;
	}

	.controls {
		margin-bottom: 1rem;
		padding: 1rem;
		background: #f8f9fa;
		border-radius: 8px;
	}

	.equation-display {
		font-size: 1.1rem;
		margin-bottom: 1rem;
		padding: 0.5rem;
		background: #e3f2fd;
		border-radius: 6px;
		border-left: 4px solid #2196f3;
	}

	.action-buttons {
		display: flex;
		gap: 0.5rem;
		flex-wrap: wrap;
	}

	.btn {
		padding: 0.5rem 1rem;
		border: none;
		border-radius: 6px;
		font-size: 0.875rem;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
	}

	.btn-secondary {
		background: #6b7280;
		color: white;
	}

	.btn-secondary:hover {
		background: #4b5563;
	}

	.btn-info {
		background: #06b6d4;
		color: white;
	}

	.btn-info:hover {
		background: #0891b2;
	}

	.graph-wrapper {
		display: flex;
		justify-content: center;
		margin: 1rem 0;
	}

	.graph {
		border: 1px solid #e5e7eb;
		border-radius: 8px;
		background: white;
	}

	.grid-line {
		stroke: #f3f4f6;
		stroke-width: 1;
	}

	.axis-line {
		stroke: #374151;
		stroke-width: 2;
	}

	.axis-label {
		font-size: 0.75rem;
		fill: #6b7280;
		font-weight: 500;
	}

	.data-point {
		cursor: pointer;
		transition: all 0.2s ease;
	}

	.data-point:hover {
		r: 7;
	}

	.regression-line {
		stroke: #ef4444;
		stroke-width: 3;
		fill: none;
		stroke-linecap: round;
		stroke-linejoin: round;
	}

	.line-chart {
		stroke-linecap: round;
		stroke-linejoin: round;
	}

	.area-chart {
		stroke: none;
	}

	.area-line {
		stroke-linecap: round;
		stroke-linejoin: round;
	}

	.bar {
		transition: opacity 0.2s ease;
	}

	.bar:hover {
		opacity: 0.8;
	}

	.drag-area {
		cursor: grab;
	}

	.drag-area:active {
		cursor: grabbing;
	}

	.instructions {
		margin-top: 1rem;
		padding: 1rem;
		background: #fef3c7;
		border-radius: 8px;
		border-left: 4px solid #f59e0b;
	}

	.instructions p {
		margin: 0 0 0.5rem 0;
		font-weight: 600;
		color: #92400e;
	}

	.instructions ul {
		margin: 0;
		padding-left: 1.5rem;
		color: #92400e;
	}

	.instructions li {
		margin-bottom: 0.25rem;
	}

	@media (max-width: 768px) {
		.action-buttons {
			flex-direction: column;
		}

		.btn {
			width: 100%;
		}
	}
</style>

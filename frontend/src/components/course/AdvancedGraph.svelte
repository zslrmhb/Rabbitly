<script lang="ts">
	import { onMount, createEventDispatcher } from 'svelte';
	import * as d3 from 'd3';

	export let data: { x: number; y: number }[] = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 5 },
		{ x: 4, y: 4 },
		{ x: 5, y: 6 },
		{ x: 6, y: 7 },
		{ x: 7, y: 8 },
		{ x: 8, y: 9 }
	];

	export let width = 600;
	export let height = 400;
	export let margin = { top: 20, right: 20, bottom: 40, left: 60 };

	const dispatch = createEventDispatcher();

	let svg: SVGSVGElement;
	let isDragging = false;
	let dragStartX = 0;
	let dragStartY = 0;
	let originalSlope = 0;
	let originalIntercept = 0;
	let dragMode: 'move' | 'rotate' = 'move';

	// Line parameters
	let slope = 1;
	let intercept = 0;

	// Input values
	let inputX = '';
	let inputY = '';
	let inputSlope = '';

	// Computed values
	$: chartWidth = width - margin.left - margin.right;
	$: chartHeight = height - margin.top - margin.bottom;

	// Scales
	$: xScale = d3
		.scaleLinear()
		.domain([0, d3.max(data, (d: { x: number; y: number }) => d.x) || 10])
		.range([0, chartWidth]);

	$: yScale = d3
		.scaleLinear()
		.domain([0, d3.max(data, (d: { x: number; y: number }) => d.y) || 10])
		.range([chartHeight, 0]);

	// Line generator
	$: lineGenerator = d3
		.line<{ x: number; y: number }>()
		.x((d: { x: number; y: number }) => xScale(d.x))
		.y((d: { x: number; y: number }) => yScale(slope * d.x + intercept));

	// Generate line data
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
		const meanY = data.reduce((sum, d) => sum + d.y, 0) / data.length;
		const ssRes = data.reduce((sum, d) => {
			const predicted = slope * d.x + intercept;
			return sum + Math.pow(d.y - predicted, 2);
		}, 0);
		const ssTot = data.reduce((sum, d) => sum + Math.pow(d.y - meanY, 2), 0);
		return ssTot === 0 ? 1 : 1 - ssRes / ssTot;
	}

	function handleMouseDown(event: MouseEvent) {
		isDragging = true;
		dragStartX = event.clientX;
		dragStartY = event.clientY;
		originalSlope = slope;
		originalIntercept = intercept;
		svg.style.cursor = 'grabbing';
	}

	function handleMouseMove(event: MouseEvent) {
		if (!isDragging) return;

		const deltaX = event.clientX - dragStartX;
		const deltaY = event.clientY - dragStartY;

		if (dragMode === 'move') {
			// Move mode: adjust intercept
			const deltaYScale = deltaY / chartHeight;
			const yRange = yScale.domain()[1] - yScale.domain()[0];
			const deltaYValue = deltaYScale * yRange;
			intercept = originalIntercept - deltaYValue;
		} else if (dragMode === 'rotate') {
			// Rotate mode: adjust slope
			const deltaXScale = deltaX / chartWidth;
			const xRange = xScale.domain()[1] - xScale.domain()[0];
			const deltaXValue = deltaXScale * xRange;
			const deltaSlope = deltaXValue * 0.1; // Sensitivity factor
			slope = originalSlope + deltaSlope;
		}
	}

	function handleMouseUp() {
		isDragging = false;
		svg.style.cursor = 'grab';
	}

	function handleInputChange() {
		const x = parseFloat(inputX);
		const y = parseFloat(inputY);

		if (!isNaN(x) && !isNaN(y)) {
			// Update slope and intercept based on new point
			const currentY = slope * x + intercept;
			const deltaY = y - currentY;
			intercept += deltaY;
		}
	}

	function handleSlopeChange() {
		const newSlope = parseFloat(inputSlope);
		if (!isNaN(newSlope)) {
			slope = newSlope;
		}
	}

	function resetToRegression() {
		calculateRegressionLine();
		inputX = '';
		inputY = '';
		inputSlope = '';
	}

	function addRandomPoint() {
		const newX = Math.floor(Math.random() * 10) + 1;
		const newY = Math.floor(Math.random() * 10) + 1;
		data = [...data, { x: newX, y: newY }];
	}

	function toggleDragMode() {
		dragMode = dragMode === 'move' ? 'rotate' : 'move';
	}

	onMount(() => {
		calculateRegressionLine();

		// Add event listeners
		svg.addEventListener('mousedown', handleMouseDown);
		document.addEventListener('mousemove', handleMouseMove);
		document.addEventListener('mouseup', handleMouseUp);

		return () => {
			document.removeEventListener('mousemove', handleMouseMove);
			document.removeEventListener('mouseup', handleMouseUp);
		};
	});
</script>

<div class="graph-container">
	<div class="controls">
		<div class="equation-display">
			<strong>Current Line:</strong> {equation}
			<br />
			<strong>R²:</strong> {rSquared.toFixed(3)}
		</div>
		
		<div class="input-controls">
			<div class="input-group">
				<label for="x-input">X coordinate:</label>
				<input
					id="x-input"
					type="number"
					bind:value={inputX}
					placeholder="Enter X"
					step="0.1"
				/>
			</div>
			
			<div class="input-group">
				<label for="y-input">Y coordinate:</label>
				<input
					id="y-input"
					type="number"
					bind:value={inputY}
					placeholder="Enter Y"
					step="0.1"
				/>
			</div>
			
			<div class="input-group">
				<label for="slope-input">Slope:</label>
				<input
					id="slope-input"
					type="number"
					bind:value={inputSlope}
					placeholder="Enter slope"
					step="0.1"
				/>
			</div>
			
			<button class="btn btn-primary" on:click={handleInputChange}>
				Update Point
			</button>
			<button class="btn btn-secondary" on:click={handleSlopeChange}>
				Update Slope
			</button>
		</div>

		<div class="action-buttons">
			<button class="btn btn-secondary" on:click={resetToRegression}>
				Reset to Best Fit
			</button>
			<button class="btn btn-accent" on:click={addRandomPoint}>
				Add Random Point
			</button>
			<button class="btn btn-info" on:click={toggleDragMode}>
				Mode: {dragMode === 'move' ? 'Move' : 'Rotate'}
			</button>
		</div>
	</div>

	<div class="graph-wrapper">
		<svg
			bind:this={svg}
			{width}
			{height}
			class="graph"
			style="cursor: grab;"
		>
			<g transform="translate({margin.left}, {margin.top})">
				<!-- Grid lines -->
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

				<!-- Axes -->
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

				<!-- Axis labels -->
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

				<!-- Data points -->
				{#each data as point}
					<circle
						cx={xScale(point.x)}
						cy={yScale(point.y)}
						r="5"
						class="data-point"
					/>
				{/each}

				<!-- Regression line -->
				<path
					d={lineGenerator(lineData)}
					class="regression-line"
					stroke-width="3"
				/>

				<!-- Drag handle -->
				<rect
					x="0"
					y="0"
					width={chartWidth}
					height={chartHeight}
					class="drag-area"
					fill="transparent"
				/>
			</g>
		</svg>
	</div>

	<div class="instructions">
		<p><strong>Instructions:</strong></p>
		<ul>
			<li>Drag anywhere on the graph to adjust the line</li>
			<li>Toggle between "Move" and "Rotate" modes to adjust intercept or slope</li>
			<li>Enter X and Y coordinates to adjust the line position</li>
			<li>Enter a slope value to directly set the line's slope</li>
			<li>Click "Reset to Best Fit" to return to the calculated regression line</li>
			<li>Click "Add Random Point" to add new data points</li>
			<li>R² value shows how well the line fits the data (1.0 = perfect fit)</li>
		</ul>
	</div>
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

	.input-controls {
		display: flex;
		gap: 1rem;
		align-items: end;
		margin-bottom: 1rem;
		flex-wrap: wrap;
	}

	.input-group {
		display: flex;
		flex-direction: column;
		gap: 0.25rem;
	}

	.input-group label {
		font-size: 0.875rem;
		font-weight: 600;
		color: #374151;
	}

	.input-group input {
		padding: 0.5rem;
		border: 2px solid #d1d5db;
		border-radius: 6px;
		font-size: 0.875rem;
		width: 100px;
	}

	.input-group input:focus {
		outline: none;
		border-color: #3b82f6;
		box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
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

	.btn-primary {
		background: #3b82f6;
		color: white;
	}

	.btn-primary:hover {
		background: #2563eb;
	}

	.btn-secondary {
		background: #6b7280;
		color: white;
	}

	.btn-secondary:hover {
		background: #4b5563;
	}

	.btn-accent {
		background: #10b981;
		color: white;
	}

	.btn-accent:hover {
		background: #059669;
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
		fill: #3b82f6;
		stroke: white;
		stroke-width: 2;
		cursor: pointer;
		transition: all 0.2s ease;
	}

	.data-point:hover {
		fill: #2563eb;
		r: 7;
	}

	.regression-line {
		stroke: #ef4444;
		stroke-width: 3;
		fill: none;
		stroke-linecap: round;
		stroke-linejoin: round;
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
		.input-controls {
			flex-direction: column;
			align-items: stretch;
		}

		.input-group input {
			width: 100%;
		}

		.action-buttons {
			flex-direction: column;
		}

		.btn {
			width: 100%;
		}
	}
</style> 
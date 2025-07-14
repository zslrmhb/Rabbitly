<script lang="ts">
	import Graph from '../../../components/course/Graph.svelte';
	import { onMount } from 'svelte';

	// Type definitions
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

	let sampleData = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 5 },
		{ x: 4, y: 4 },
		{ x: 5, y: 6 },
		{ x: 6, y: 7 },
		{ x: 7, y: 8 },
		{ x: 8, y: 9 }
	];

	let customData = [
		{ x: 1, y: 1 },
		{ x: 2, y: 3 },
		{ x: 3, y: 2 },
		{ x: 4, y: 5 },
		{ x: 5, y: 4 },
		{ x: 6, y: 6 }
	];

	let selectedDataset = 'sample';
	let selectedGraphType: GraphType = 'regression';
	$: currentData = selectedDataset === 'sample' ? sampleData : customData;
	
	// Graph configurations for different types
	const graphConfigs: Record<GraphType, GraphConfig> = {
		regression: {
			type: 'regression',
			title: 'Interactive Regression Graph',
			interactive: true,
			showGrid: true,
			showAxes: true,
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
			}
		},
		scatter: {
			type: 'scatter',
			title: 'Scatter Plot',
			interactive: false,
			showGrid: true,
			showAxes: true,
			pointConfig: {
				radius: 6,
				fillColor: '#10b981',
				strokeColor: 'white',
				strokeWidth: 2
			}
		},
		line: {
			type: 'line',
			title: 'Line Chart',
			interactive: false,
			showGrid: true,
			showAxes: true,
			lineConfig: {
				strokeWidth: 3,
				strokeColor: '#8b5cf6',
				dashArray: 'none'
			},
			pointConfig: {
				radius: 4,
				fillColor: '#8b5cf6',
				strokeColor: 'white',
				strokeWidth: 2
			}
		},
		bar: {
			type: 'bar',
			title: 'Bar Chart',
			interactive: false,
			showGrid: true,
			showAxes: true,
			barConfig: {
				width: 25,
				fillColor: '#f59e0b',
				strokeColor: 'white',
				strokeWidth: 1
			}
		},
		area: {
			type: 'area',
			title: 'Area Chart',
			interactive: false,
			showGrid: true,
			showAxes: true,
			lineConfig: {
				strokeWidth: 2,
				strokeColor: '#06b6d4',
				dashArray: 'none'
			},
			areaConfig: {
				fillColor: '#06b6d4',
				opacity: 0.3
			}
		}
	};
</script>

<svelte:head>
	<title>Interactive Graph Demo - Multi-Type</title>
</svelte:head>

<div class="container">
	<header class="header">
		<h1>Interactive Graph Component</h1>
		<p>
			A comprehensive graph component supporting multiple chart types with interactive features.
			Switch between different graph types to see the component's flexibility.
		</p>
	</header>

	<div class="controls">
		<div class="control-group">
			<div class="dataset-selector">
				<label for="dataset">Select Dataset:</label>
				<select id="dataset" bind:value={selectedDataset}>
					<option value="sample">Sample Dataset</option>
					<option value="custom">Custom Dataset</option>
				</select>
			</div>
			
			<div class="graph-selector">
				<label for="graph">Select Graph Type:</label>
				<select id="graph" bind:value={selectedGraphType}>
					<option value="regression">Regression (Interactive)</option>
					<option value="scatter">Scatter Plot</option>
					<option value="line">Line Chart</option>
					<option value="bar">Bar Chart</option>
					<option value="area">Area Chart</option>
				</select>
			</div>
		</div>
	</div>

	<div class="graph-section">
		<Graph 
			data={currentData} 
			config={graphConfigs[selectedGraphType]} 
			width={700} 
			height={500} 
		/>
	</div>

	<div class="features">
		<h2>Features</h2>
		<div class="feature-grid">
			<div class="feature-card">
				<h3>🎯 Multiple Graph Types</h3>
				<p>Support for regression, scatter, line, bar, and area charts with unified API.</p>
			</div>
			<div class="feature-card">
				<h3>🖱️ Interactive Regression</h3>
				<p>Drag to adjust the regression line with move and rotate modes.</p>
			</div>
			<div class="feature-card">
				<h3>📊 R² Calculation</h3>
				<p>Real-time R-squared calculation to measure line fit quality.</p>
			</div>
			<div class="feature-card">
				<h3>🎨 Customizable Styling</h3>
				<p>Configurable colors, sizes, and visual properties for all elements.</p>
			</div>
			<div class="feature-card">
				<h3>📱 Responsive Design</h3>
				<p>Works seamlessly on desktop and mobile devices.</p>
			</div>
			<div class="feature-card">
				<h3>⚙️ Flexible Configuration</h3>
				<p>Easy to configure grid, axes, legends, and interaction settings.</p>
			</div>
		</div>
	</div>

	<div class="explanation">
		<h2>How It Works</h2>
		<div class="explanation-content">
			<div class="explanation-section">
				<h3>Unified Component Architecture</h3>
				<p>
					The Graph component uses a single, flexible architecture that adapts to different graph types
					through configuration. Each graph type has optimized rendering while sharing common features.
				</p>
			</div>

			<div class="explanation-section">
				<h3>Interactive Features</h3>
				<ul>
					<li><strong>Regression Mode:</strong> Drag to adjust line position and slope with real-time equation updates</li>
					<li><strong>Dual Drag Modes:</strong> Toggle between move (adjust intercept) and rotate (adjust slope)</li>
					<li><strong>R² Calculation:</strong> Automatic calculation of how well the line fits the data</li>
					<li><strong>Reset Functionality:</strong> Return to mathematically calculated best fit line</li>
				</ul>
			</div>

			<div class="explanation-section">
				<h3>Graph Types</h3>
				<ul>
					<li><strong>Regression:</strong> Interactive line with drag controls and R² calculation</li>
					<li><strong>Scatter:</strong> Simple point plot with customizable styling</li>
					<li><strong>Line:</strong> Connected line chart with optional point markers</li>
					<li><strong>Bar:</strong> Vertical bar chart with configurable bar width and colors</li>
					<li><strong>Area:</strong> Filled area chart with customizable opacity</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<style>
	.container {
		max-width: 1200px;
		margin: 0 auto;
		padding: 2rem;
	}

	.header {
		text-align: center;
		margin-bottom: 3rem;
	}

	.header h1 {
		font-size: 2.5rem;
		font-weight: 700;
		color: #1f2937;
		margin-bottom: 1rem;
	}

	.header p {
		font-size: 1.1rem;
		color: #6b7280;
		max-width: 600px;
		margin: 0 auto;
		line-height: 1.6;
	}

	.controls {
		margin-bottom: 2rem;
		display: flex;
		justify-content: center;
	}

	.control-group {
		display: flex;
		gap: 1rem;
		flex-wrap: wrap;
		justify-content: center;
	}

	.dataset-selector,
	.graph-selector {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.dataset-selector label,
	.graph-selector label {
		font-size: 0.875rem;
		font-weight: 600;
		color: #374151;
	}

	.dataset-selector select,
	.graph-selector select {
		padding: 0.5rem;
		border: 2px solid #d1d5db;
		border-radius: 6px;
		font-size: 0.875rem;
		background: white;
		min-width: 150px;
	}

	.dataset-selector select:focus,
	.graph-selector select:focus {
		outline: none;
		border-color: #3b82f6;
		box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
	}

	.graph-section {
		margin-bottom: 3rem;
		display: flex;
		justify-content: center;
	}

	.features {
		margin-bottom: 3rem;
	}

	.features h2 {
		font-size: 2rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 2rem;
		text-align: center;
	}

	.feature-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 1.5rem;
	}

	.feature-card {
		background: white;
		padding: 1.5rem;
		border-radius: 12px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		border: 1px solid #e5e7eb;
		transition: all 0.2s ease;
	}

	.feature-card:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
	}

	.feature-card h3 {
		font-size: 1.25rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 0.75rem;
	}

	.feature-card p {
		color: #6b7280;
		line-height: 1.5;
		margin: 0;
	}

	.explanation {
		background: #f8f9fa;
		padding: 2rem;
		border-radius: 12px;
	}

	.explanation h2 {
		font-size: 2rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 2rem;
		text-align: center;
	}

	.explanation-content {
		display: grid;
		gap: 2rem;
	}

	.explanation-section {
		background: white;
		padding: 1.5rem;
		border-radius: 8px;
		box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	}

	.explanation-section h3 {
		font-size: 1.25rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 1rem;
	}

	.explanation-section p {
		color: #6b7280;
		line-height: 1.6;
		margin-bottom: 1rem;
	}

	.explanation-section ul {
		color: #6b7280;
		line-height: 1.6;
		padding-left: 1.5rem;
	}

	.explanation-section li {
		margin-bottom: 0.5rem;
	}

	@media (max-width: 768px) {
		.container {
			padding: 1rem;
		}

		.header h1 {
			font-size: 2rem;
		}

		.control-group {
			flex-direction: column;
			align-items: center;
		}

		.feature-grid {
			grid-template-columns: 1fr;
		}

		.explanation {
			padding: 1rem;
		}
	}
</style> 
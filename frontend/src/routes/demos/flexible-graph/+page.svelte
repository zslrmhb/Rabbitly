<script lang="ts">
	import Graph from '../../../components/course/Graph.svelte';

	// Type definitions (matching the Graph component)
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

	// Sample data for different graph types
	const regressionData: DataPoint[] = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 5 },
		{ x: 4, y: 4 },
		{ x: 5, y: 6 },
		{ x: 6, y: 7 },
		{ x: 7, y: 8 },
		{ x: 8, y: 9 }
	];

	const scatterData: DataPoint[] = [
		{ x: 1, y: 3, color: '#3b82f6' },
		{ x: 2, y: 5, color: '#ef4444' },
		{ x: 3, y: 2, color: '#10b981' },
		{ x: 4, y: 7, color: '#f59e0b' },
		{ x: 5, y: 4, color: '#8b5cf6' },
		{ x: 6, y: 8, color: '#ec4899' },
		{ x: 7, y: 6, color: '#06b6d4' },
		{ x: 8, y: 9, color: '#84cc16' }
	];

	const lineData: DataPoint[] = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 1 },
		{ x: 4, y: 6 },
		{ x: 5, y: 3 },
		{ x: 6, y: 8 },
		{ x: 7, y: 5 },
		{ x: 8, y: 9 }
	];

	const barData: DataPoint[] = [
		{ x: 1, y: 5 },
		{ x: 2, y: 8 },
		{ x: 3, y: 3 },
		{ x: 4, y: 9 },
		{ x: 5, y: 6 },
		{ x: 6, y: 4 },
		{ x: 7, y: 7 },
		{ x: 8, y: 2 }
	];

	const areaData: DataPoint[] = [
		{ x: 1, y: 2 },
		{ x: 2, y: 5 },
		{ x: 3, y: 3 },
		{ x: 4, y: 7 },
		{ x: 5, y: 4 },
		{ x: 6, y: 8 },
		{ x: 7, y: 6 },
		{ x: 8, y: 9 }
	];

	// Graph configurations
	const regressionConfig: GraphConfig = {
		type: 'regression',
		title: 'Interactive Regression Line',
		xLabel: 'X Values',
		yLabel: 'Y Values',
		showGrid: true,
		showAxes: true,
		interactive: true,
		colors: ['#3b82f6', '#ef4444', '#10b981'],
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
	};

	const scatterConfig: GraphConfig = {
		type: 'scatter',
		title: 'Scatter Plot',
		xLabel: 'X Values',
		yLabel: 'Y Values',
		showGrid: true,
		showAxes: true,
		interactive: false,
		colors: ['#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6'],
		pointConfig: {
			radius: 6,
			fillColor: '#3b82f6',
			strokeColor: 'white',
			strokeWidth: 2
		}
	};

	const lineConfig: GraphConfig = {
		type: 'line',
		title: 'Line Chart',
		xLabel: 'Time',
		yLabel: 'Values',
		showGrid: true,
		showAxes: true,
		interactive: false,
		colors: ['#3b82f6'],
		lineConfig: {
			strokeWidth: 3,
			strokeColor: '#3b82f6',
			dashArray: 'none'
		},
		pointConfig: {
			radius: 4,
			fillColor: '#3b82f6',
			strokeColor: 'white',
			strokeWidth: 2
		}
	};

	const barConfig: GraphConfig = {
		type: 'bar',
		title: 'Bar Chart',
		xLabel: 'Categories',
		yLabel: 'Values',
		showGrid: true,
		showAxes: true,
		interactive: false,
		colors: ['#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6'],
		barConfig: {
			width: 25,
			fillColor: '#3b82f6',
			strokeColor: 'white',
			strokeWidth: 1
		}
	};

	const areaConfig: GraphConfig = {
		type: 'area',
		title: 'Area Chart',
		xLabel: 'Time',
		yLabel: 'Values',
		showGrid: true,
		showAxes: true,
		interactive: false,
		colors: ['#3b82f6'],
		lineConfig: {
			strokeWidth: 2,
			strokeColor: '#3b82f6',
			dashArray: 'none'
		},
		areaConfig: {
			fillColor: '#3b82f6',
			opacity: 0.3
		}
	};

	// Custom configurations for demonstration
	const customScatterConfig: GraphConfig = {
		type: 'scatter',
		title: 'Custom Scatter Plot',
		showGrid: false,
		showAxes: true,
		interactive: false,
		colors: ['#ef4444', '#10b981', '#f59e0b'],
		pointConfig: {
			radius: 8,
			fillColor: '#ef4444',
			strokeColor: '#dc2626',
			strokeWidth: 3
		}
	};

	const customLineConfig: GraphConfig = {
		type: 'line',
		title: 'Dashed Line Chart',
		showGrid: true,
		showAxes: true,
		interactive: false,
		colors: ['#10b981'],
		lineConfig: {
			strokeWidth: 4,
			strokeColor: '#10b981',
			dashArray: '5,5'
		},
		pointConfig: {
			radius: 5,
			fillColor: '#10b981',
			strokeColor: 'white',
			strokeWidth: 2
		}
	};

	let selectedGraphType = 'regression';
	let selectedConfig = regressionConfig;
	let selectedData = regressionData;

	function updateGraph() {
		switch (selectedGraphType) {
			case 'regression':
				selectedConfig = regressionConfig;
				selectedData = regressionData;
				break;
			case 'scatter':
				selectedConfig = scatterConfig;
				selectedData = scatterData;
				break;
			case 'line':
				selectedConfig = lineConfig;
				selectedData = lineData;
				break;
			case 'bar':
				selectedConfig = barConfig;
				selectedData = barData;
				break;
			case 'area':
				selectedConfig = areaConfig;
				selectedData = areaData;
				break;
		}
	}

	$: updateGraph();
</script>

<svelte:head>
	<title>Flexible Graph Demo - Rabbitly</title>
</svelte:head>

<div class="container">
	<header class="header">
		<h1>📊 Flexible Graph Component</h1>
		<p>
			Explore the configurable graph component that supports multiple graph types with customizable options.
		</p>
	</header>

	<div class="controls">
		<div class="control-group">
			<div class="graph-selector">
				<label for="graph-type">Select Graph Type:</label>
				<select id="graph-type" bind:value={selectedGraphType}>
					<option value="regression">Regression Line (Interactive)</option>
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
			data={selectedData} 
			config={selectedConfig} 
			width={700} 
			height={500} 
		/>
	</div>

	<div class="features">
		<h2>Graph Types & Features</h2>
		<div class="feature-grid">
			<div class="feature-card">
				<h3>📈 Regression Line</h3>
				<p>Interactive regression line with drag controls, R² calculation, and dual modes (move/rotate).</p>
				<ul>
					<li>Drag to adjust line position</li>
					<li>Toggle between move and rotate modes</li>
					<li>Real-time equation display</li>
					<li>R² goodness of fit</li>
				</ul>
			</div>
			<div class="feature-card">
				<h3>🔵 Scatter Plot</h3>
				<p>Customizable scatter plot with individual point colors and hover effects.</p>
				<ul>
					<li>Individual point colors</li>
					<li>Configurable point sizes</li>
					<li>Hover effects</li>
					<li>Grid and axis options</li>
				</ul>
			</div>
			<div class="feature-card">
				<h3>📉 Line Chart</h3>
				<p>Smooth line charts with customizable stroke styles and point markers.</p>
				<ul>
					<li>Solid and dashed lines</li>
					<li>Configurable stroke width</li>
					<li>Point markers</li>
					<li>Custom colors</li>
				</ul>
			</div>
			<div class="feature-card">
				<h3>📊 Bar Chart</h3>
				<p>Bar charts with customizable widths, colors, and hover effects.</p>
				<ul>
					<li>Configurable bar width</li>
					<li>Individual bar colors</li>
					<li>Hover effects</li>
					<li>Stroke customization</li>
				</ul>
			</div>
			<div class="feature-card">
				<h3>🌊 Area Chart</h3>
				<p>Area charts with fill colors and opacity controls.</p>
				<ul>
					<li>Fill area below line</li>
					<li>Configurable opacity</li>
					<li>Line overlay</li>
					<li>Custom fill colors</li>
				</ul>
			</div>
			<div class="feature-card">
				<h3>⚙️ Configuration</h3>
				<p>Highly configurable through code with TypeScript support.</p>
				<ul>
					<li>TypeScript interfaces</li>
					<li>Default configurations</li>
					<li>Custom styling options</li>
					<li>Responsive design</li>
				</ul>
			</div>
		</div>
	</div>

	<div class="code-examples">
		<h2>Code Examples</h2>
		<div class="example-grid">
			<div class="code-example">
				<h3>Basic Regression Graph</h3>
				<pre><code>{`const config: GraphConfig = {
  type: 'regression',
  title: 'Interactive Regression',
  interactive: true,
  showGrid: true,
  showAxes: true
};

<Graph 
  data={data} 
  config={config} 
  width={600} 
  height={400} 
/>`}</code></pre>
			</div>
			<div class="code-example">
				<h3>Custom Scatter Plot</h3>
				<pre><code>{`const config: GraphConfig = {
  type: 'scatter',
  title: 'Custom Scatter',
  showGrid: false,
  pointConfig: {
    radius: 8,
    fillColor: '#ef4444',
    strokeColor: '#dc2626',
    strokeWidth: 3
  }
};`}</code></pre>
			</div>
			<div class="code-example">
				<h3>Dashed Line Chart</h3>
				<pre><code>{`const config: GraphConfig = {
  type: 'line',
  lineConfig: {
    strokeWidth: 4,
    strokeColor: '#10b981',
    dashArray: '5,5'
  },
  pointConfig: {
    radius: 5,
    fillColor: '#10b981'
  }
};`}</code></pre>
			</div>
			<div class="code-example">
				<h3>Bar Chart Configuration</h3>
				<pre><code>{`const config: GraphConfig = {
  type: 'bar',
  barConfig: {
    width: 25,
    fillColor: '#3b82f6',
    strokeColor: 'white',
    strokeWidth: 1
  }
};`}</code></pre>
			</div>
		</div>
	</div>

	<div class="configuration">
		<h2>Configuration Options</h2>
		<div class="config-grid">
			<div class="config-section">
				<h3>Graph Types</h3>
				<ul>
					<li><code>'regression'</code> - Interactive regression line</li>
					<li><code>'scatter'</code> - Scatter plot</li>
					<li><code>'line'</code> - Line chart</li>
					<li><code>'bar'</code> - Bar chart</li>
					<li><code>'area'</code> - Area chart</li>
				</ul>
			</div>
			<div class="config-section">
				<h3>Display Options</h3>
				<ul>
					<li><code>title</code> - Graph title</li>
					<li><code>showGrid</code> - Show/hide grid lines</li>
					<li><code>showAxes</code> - Show/hide axes</li>
					<li><code>interactive</code> - Enable drag interactions</li>
				</ul>
			</div>
			<div class="config-section">
				<h3>Styling Options</h3>
				<ul>
					<li><code>colors</code> - Color palette array</li>
					<li><code>lineConfig</code> - Line styling options</li>
					<li><code>pointConfig</code> - Point styling options</li>
					<li><code>barConfig</code> - Bar styling options</li>
					<li><code>areaConfig</code> - Area styling options</li>
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

	.graph-selector {
		display: flex;
		align-items: center;
		gap: 1rem;
		padding: 1rem;
		background: #f8f9fa;
		border-radius: 8px;
		border: 1px solid #e5e7eb;
	}

	.graph-selector label {
		font-weight: 600;
		color: #374151;
	}

	.graph-selector select {
		padding: 0.5rem;
		border: 2px solid #d1d5db;
		border-radius: 6px;
		font-size: 0.875rem;
		background: white;
		min-width: 200px;
	}

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
		grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
		gap: 1.5rem;
	}

	.feature-card {
		background: white;
		padding: 1.5rem;
		border-radius: 12px;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
		border: 1px solid #e5e7eb;
		transition: transform 0.2s ease, box-shadow 0.2s ease;
	}

	.feature-card:hover {
		transform: translateY(-2px);
		box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
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
		margin-bottom: 1rem;
	}

	.feature-card ul {
		color: #6b7280;
		line-height: 1.6;
		padding-left: 1.5rem;
	}

	.feature-card li {
		margin-bottom: 0.25rem;
	}

	.code-examples {
		margin-bottom: 3rem;
	}

	.code-examples h2 {
		font-size: 2rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 2rem;
		text-align: center;
	}

	.example-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
		gap: 1.5rem;
	}

	.code-example {
		background: #1f2937;
		padding: 1.5rem;
		border-radius: 8px;
		border: 1px solid #374151;
	}

	.code-example h3 {
		font-size: 1.1rem;
		font-weight: 600;
		color: #f9fafb;
		margin-bottom: 1rem;
	}

	.code-example pre {
		margin: 0;
		overflow-x: auto;
	}

	.code-example code {
		color: #e5e7eb;
		font-family: 'Courier New', monospace;
		font-size: 0.875rem;
		line-height: 1.4;
	}

	.configuration {
		background: #f8f9fa;
		padding: 2rem;
		border-radius: 12px;
		border: 1px solid #e5e7eb;
	}

	.configuration h2 {
		font-size: 2rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 2rem;
		text-align: center;
	}

	.config-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 2rem;
	}

	.config-section {
		background: white;
		padding: 1.5rem;
		border-radius: 8px;
		border: 1px solid #e5e7eb;
	}

	.config-section h3 {
		font-size: 1.25rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 1rem;
	}

	.config-section ul {
		color: #6b7280;
		line-height: 1.6;
		padding-left: 1.5rem;
	}

	.config-section li {
		margin-bottom: 0.5rem;
	}

	.config-section code {
		background: #f3f4f6;
		padding: 0.125rem 0.25rem;
		border-radius: 4px;
		font-family: 'Courier New', monospace;
		font-size: 0.875rem;
		color: #374151;
	}

	@media (max-width: 768px) {
		.container {
			padding: 1rem;
		}

		.header h1 {
			font-size: 2rem;
		}

		.feature-grid {
			grid-template-columns: 1fr;
		}

		.example-grid {
			grid-template-columns: 1fr;
		}

		.config-grid {
			grid-template-columns: 1fr;
		}
	}
</style> 
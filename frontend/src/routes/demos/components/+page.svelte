<script lang="ts">
	import Graph from '$components/course/Graph.svelte';
	import AdvancedGraph from '$components/course/AdvancedGraph.svelte';
	import MultipleChoice from '$components/course/MultipleChoice.svelte';
	import MultipleChoiceM from '$components/course/MultipleChoiceM.svelte';
	import ProgressBar from '$components/course/ProgressBar.svelte';
	import TextBox from '$components/course/TextBox.svelte';
	import Title from '$components/course/Title.svelte';
	import CodeEditor from '$components/CodeEditor.svelte';

	let progress = 0;
	let showAdvancedGraph = false;

	function handleCorrect() {
		progress += 0.2;
	}

	const sampleData = [
		{ x: 1, y: 2 },
		{ x: 2, y: 4 },
		{ x: 3, y: 5 },
		{ x: 4, y: 4 },
		{ x: 5, y: 6 },
		{ x: 6, y: 7 },
		{ x: 7, y: 8 },
		{ x: 8, y: 9 }
	];

	const paragraphs = [
		'Welcome to the comprehensive component showcase! This page demonstrates all the interactive components available in the Rabbitly project.',
		'Each component is designed to be reusable, accessible, and highly customizable for educational content creation.'
	];

	const question = 'Which component allows for interactive regression line manipulation?';
	const choices = [
		{ label: 'A', text: 'MultipleChoice' },
		{ label: 'B', text: 'Graph' },
		{ label: 'C', text: 'TextBox' },
		{ label: 'D', text: 'ProgressBar' }
	];
	const answer = ['B'];

	const multiQuestion = 'Which of the following are valid Svelte features?';
	const multiChoices = [
		{ label: 'A', text: 'Reactive statements' },
		{ label: 'B', text: 'Component props' },
		{ label: 'C', text: 'Event dispatching' },
		{ label: 'D', text: 'Virtual DOM' }
	];
	const multiAnswer = ['A', 'B', 'C'];

	const instructions = `
		<h3>Code Editor Component</h3>
		<p>This is a code editor component with:</p>
		<ul>
			<li>Instruction panel</li>
			<li>Code textarea</li>
			<li>Output display</li>
			<li>Progress tracking</li>
		</ul>
	`;
</script>

<svelte:head>
	<title>Component Showcase - Rabbitly</title>
</svelte:head>

<div class="container">
	<header class="header">
		<h1>🎨 Component Showcase</h1>
		<p>Explore all the interactive components available in the Rabbitly project</p>
	</header>

	<ProgressBar value={progress} />

	<!-- Title Component -->
	<section class="component-section">
		<Title text="1. Title Component" level="h2" />
		<p class="description">
			The Title component provides consistent heading styling with customizable levels (h1-h6).
		</p>
		<div class="example">
			<Title text="This is a sample title" level="h3" />
		</div>
	</section>

	<!-- TextBox Component -->
	<section class="component-section">
		<Title text="2. TextBox Component" level="h2" />
		<p class="description">
			Displays formatted text content with clean styling and proper spacing.
		</p>
		<div class="example">
			<TextBox {paragraphs} />
		</div>
	</section>

	<!-- Multiple Choice Component -->
	<section class="component-section">
		<Title text="3. Multiple Choice Component" level="h2" />
		<p class="description">
			Interactive quiz component with single answer selection, feedback, and animations.
		</p>
		<div class="example">
			<MultipleChoice
				{question}
				{choices}
				correctAnswer={answer}
				on:correct={handleCorrect}
			/>
		</div>
	</section>

	<!-- Multiple Choice (Multi-select) Component -->
	<section class="component-section">
		<Title text="4. Multiple Choice (Multi-select) Component" level="h2" />
		<p class="description">
			Advanced quiz component that allows selecting multiple correct answers.
		</p>
		<div class="example">
			<MultipleChoiceM
				question={multiQuestion}
				choices={multiChoices}
				correctAnswer={multiAnswer}
				on:correct={handleCorrect}
			/>
		</div>
	</section>

	<!-- Basic Graph Component -->
	<section class="component-section">
		<Title text="5. Basic Graph Component" level="h2" />
		<p class="description">
			Interactive regression line graph with drag controls and coordinate input.
		</p>
		<div class="example">
			<Graph data={sampleData} width={600} height={400} />
		</div>
	</section>

	<!-- Advanced Graph Component -->
	<section class="component-section">
		<Title text="6. Advanced Graph Component" level="h2" />
		<p class="description">
			Enhanced graph with dual drag modes (move/rotate), R² calculation, and slope controls.
		</p>
		<div class="example">
			<AdvancedGraph data={sampleData} width={600} height={400} />
		</div>
	</section>

	<!-- Code Editor Component -->
	<section class="component-section">
		<Title text="7. Code Editor Component" level="h2" />
		<p class="description">
			Full-screen code editor with instruction panel, code area, and output display.
		</p>
		<div class="example">
			<CodeEditor {instructions} />
		</div>
	</section>

	<!-- Component Summary -->
	<section class="component-section">
		<Title text="Component Summary" level="h2" />
		<div class="summary-grid">
			<div class="summary-card">
				<h3>📝 Content Components</h3>
				<ul>
					<li><strong>Title:</strong> Consistent heading styling</li>
					<li><strong>TextBox:</strong> Formatted text display</li>
					<li><strong>ProgressBar:</strong> Progress tracking</li>
				</ul>
			</div>
			<div class="summary-card">
				<h3>🎯 Interactive Components</h3>
				<ul>
					<li><strong>MultipleChoice:</strong> Single answer quizzes</li>
					<li><strong>MultipleChoiceM:</strong> Multi-select quizzes</li>
					<li><strong>Graph:</strong> Basic regression line</li>
					<li><strong>AdvancedGraph:</strong> Enhanced graph controls</li>
				</ul>
			</div>
			<div class="summary-card">
				<h3>💻 Editor Components</h3>
				<ul>
					<li><strong>CodeEditor:</strong> Full-screen code editor</li>
					<li><strong>s.svelte:</strong> Resizable editor layout</li>
					<li><strong>s2.svelte:</strong> Simplified editor</li>
				</ul>
			</div>
		</div>
	</section>

	<!-- Navigation -->
	<section class="component-section">
		<Title text="Demo Pages" level="h2" />
		<div class="demo-links">
			<a href="/demos/graph" class="demo-link">
				📊 Graph Demo
			</a>
			<a href="/demos/course" class="demo-link">
				📚 Course Demo
			</a>
			<a href="/demos/editor" class="demo-link">
				💻 Editor Demo
			</a>
			<a href="/demos/scrollytelling" class="demo-link">
				📖 Scrollytelling Demo
			</a>
		</div>
	</section>
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

	.component-section {
		margin-bottom: 4rem;
		padding: 2rem;
		background: white;
		border-radius: 12px;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
		border: 1px solid #e5e7eb;
	}

	.description {
		font-size: 1rem;
		color: #6b7280;
		margin-bottom: 1.5rem;
		line-height: 1.6;
	}

	.example {
		margin-top: 1.5rem;
		padding: 1.5rem;
		background: #f8f9fa;
		border-radius: 8px;
		border: 1px solid #e5e7eb;
	}

	.summary-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 1.5rem;
		margin-top: 1.5rem;
	}

	.summary-card {
		background: #f8f9fa;
		padding: 1.5rem;
		border-radius: 8px;
		border: 1px solid #e5e7eb;
	}

	.summary-card h3 {
		font-size: 1.25rem;
		font-weight: 600;
		color: #1f2937;
		margin-bottom: 1rem;
	}

	.summary-card ul {
		margin: 0;
		padding-left: 1.5rem;
		color: #6b7280;
		line-height: 1.6;
	}

	.summary-card li {
		margin-bottom: 0.5rem;
	}

	.demo-links {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
		gap: 1rem;
		margin-top: 1.5rem;
	}

	.demo-link {
		display: block;
		padding: 1rem 1.5rem;
		background: #3b82f6;
		color: white;
		text-decoration: none;
		border-radius: 8px;
		font-weight: 600;
		text-align: center;
		transition: all 0.2s ease;
	}

	.demo-link:hover {
		background: #2563eb;
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
	}

	@media (max-width: 768px) {
		.container {
			padding: 1rem;
		}

		.header h1 {
			font-size: 2rem;
		}

		.component-section {
			padding: 1.5rem;
		}

		.summary-grid {
			grid-template-columns: 1fr;
		}

		.demo-links {
			grid-template-columns: 1fr;
		}
	}
</style> 
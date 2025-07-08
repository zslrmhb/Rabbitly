<script lang="ts">
	import MultipleChoice from '$components/course/MultipleChoice.svelte';
	import MultipleChoiceM from '$components/course/MultipleChoiceM.svelte';
	import ProgressBar from '$components/course/ProgressBar.svelte';
	import TextBox from '$components/course/TextBox.svelte';
	import Title from '$components/course/Title.svelte';

	let progress = 0;

	function handleCorrect() {
		progress += 1 / 3;
	}

	const paragraphs = [
		'Debugging is like being the detective in a crime movie where you are also the murderer… but you don’t remember doing it, and your only clues are cryptic error messages like “Segmentation fault (core dumped).” You fix one bug and suddenly five more show up like hydra heads. Somewhere, deep in the stack trace, your print("made it here") messages silently weep.',
		'Dating as a computer scientist is hard. Every time I try to make a move, I end up in an infinite loop of “let’s just be friends.” I even tried applying machine learning to my love life, but my heart kept overfitting. My last crush said I lacked recursion—I just kept going back to my ex.',
		'Being a CS student means your sleep schedule is optimized with FIFO (First In, First Out) logic: sleep goes in at midnight and is pushed out by deadlines. You drink so much coffee, your compiler started warning: Possible stack overflow: caffeine levels exceeding recursion depth. But hey, at least you know how to build your own misery-tracking app—now that’s full stack.'
	];

	const question1 = 'Which of the following member is gay?';
	const choices1 = [
		{ label: 'A', text: 'Andy' },
		{ label: 'B', text: 'David' },
		{ label: 'C', text: 'Hongbin' },
		{ label: 'D', text: 'Leon' },
		{ label: 'E', text: 'Luca' },
		{ label: 'F', text: 'Shiwei' },
		{ label: 'G', text: 'Zhen' }
	];
	const answer1 = ['G'];

	const question2 = 'Which statement best describes a regression line?';
	const choices2 = [
		{ label: 'A', text: 'A line that passes through all data points' },
		{ label: 'B', text: 'A line that minimizes the squared distances to all data points' },
		{ label: 'C', text: 'A line that connects the first and last data points' }
	];
	const answer2 = ['B'];

	const question3 = 'Which of the following are prime numbers?';
	const choices3 = [
		{ label: 'A', text: '2' },
		{ label: 'B', text: '3' },
		{ label: 'C', text: '4' },
		{ label: 'D', text: '5' }
	];
	const answer3 = ['A', 'B', 'D'];

	let showSecond = false;
	let showThird = false;
</script>

<div class="main-content">
	<Title text="Computer Science Jokes" level="h1" />
	<TextBox {paragraphs} />

	<Title text="1.1 Questions" level="h2" />
	<MultipleChoice
		question={question1}
		choices={choices1}
		correctAnswer={answer1}
		on:correct={() => (showSecond = true)}
		on:correct={handleCorrect}
	/>

	{#if showSecond}
		<MultipleChoice
			question={question2}
			choices={choices2}
			correctAnswer={answer2}
			on:correct={() => (showThird = true)}
			on:correct={handleCorrect}
		/>
	{/if}

	{#if showThird}
		<MultipleChoiceM
			question={question3}
			choices={choices3}
			correctAnswer={answer3}
			on:correct={handleCorrect}
		/>
	{/if}
</div>

<style>
	.main-content {
		padding-top: 3rem;
		max-width: 800px;
		margin: 0 auto;
	}
</style>

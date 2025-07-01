<script lang="ts">
	import MultipleChoice from '$components/course/MultipleChoice.svelte';

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

	const question3 = 'What is the capital of France?';
	const choices3 = [
		{ label: 'A', text: 'Berlin' },
		{ label: 'B', text: 'Madrid' },
		{ label: 'C', text: 'Paris' }
	];
	const answer3 = ['C'];

	let showSecond = false;
	let showThird = false;
</script>

<!-- First question -->
<MultipleChoice
  question={question1}
  choices={choices1}
  correctAnswer={answer1}
  on:correct={() => showSecond = true}
/>

<!-- Second question -->
{#if showSecond}
	<MultipleChoice
		question={question2}
		choices={choices2}
		correctAnswer={answer2}
		on:correct={() => showThird = true}
	/>
{/if}

<!-- Third question -->
{#if showThird}
	<MultipleChoice
		question={question3}
		choices={choices3}
		correctAnswer={answer3}
	/>
{/if}

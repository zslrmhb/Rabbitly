<script lang="ts">
	import MultipleChoice from '$components/course/MultipleChoice.svelte';
	import MultipleChoiceM from '$components/course/MultipleChoiceM.svelte';

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
	<MultipleChoiceM
		question={question3}
		choices={choices3}
		correctAnswer={answer3}
	/>
{/if}

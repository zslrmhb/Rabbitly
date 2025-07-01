<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	export let question: string;
	export let choices: { label: string; text: string }[];
	export let correctAnswer: string[]; // ← multiple correct answers
  
	const dispatch = createEventDispatcher();
	let selected: string = '';
  
	function handleClick(label: string) {
	  selected = label;
	  if (correctAnswer.includes(label)) {
		dispatch('correct');
	  }
	}
  </script>
  

<div class="question">{question}</div>

{#each choices as choice}
	<div
		class="choice
		{selected === choice.label ? 'selected' : ''}
		{selected === choice.label
			? correctAnswer.includes(choice.label)
				? ' correct'
				: ' incorrect'
			: ''}"
		on:click={() => handleClick(choice.label)}
	>
		<span class="label">{choice.label}.</span>
		{choice.text}
	</div>
{/each}

<style>
	.question {
		font-size: 1.25rem;
		margin-bottom: 1rem;
		font-weight: 600;
	}

	.choice {
		border: 2px solid #ccc;
		border-radius: 12px;
		padding: 1rem 1.25rem;
		margin: 0.5rem 0;
		cursor: pointer;
		transition: all 0.2s ease;
		font-size: 1rem;
		display: flex;
		align-items: center;
	}

	/* .choice:hover {
		background-color: #f9fafb;
		border-color: #bbb;
	} */

	.selected {
		border-color: #3b82f6;
		background-color: #eff6ff;
	}

	.correct {
		border-color: #22c55e;
		background-color: #dcfce7;
	}

	.incorrect {
		border-color: #ef4444;
		background-color: #fee2e2;
	}

	.label {
		font-weight: bold;
		margin-right: 0.5rem;
	}
</style>

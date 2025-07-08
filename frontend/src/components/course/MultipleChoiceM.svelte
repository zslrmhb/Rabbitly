<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	export let question: string;
	export let choices: { label: string; text: string }[];
	export let correctAnswer: string[];

	const dispatch = createEventDispatcher();
	let selected: string[] = [];
	let submitted = false;
	let isCorrect = false;

	function toggle(label: string) {
	if (isCorrect) return; // Don't allow changes after correct

	if (selected.includes(label)) {
		selected = selected.filter((l) => l !== label);
	} else {
		selected = [...selected, label];
	}

	// Clear submission state if user is trying again
	if (submitted && !isCorrect) {
		submitted = false;
	}
}


	function submitAnswer() {
		submitted = true;
		const selectedSorted = [...selected].sort();
		const correctSorted = [...correctAnswer].sort();
		isCorrect = JSON.stringify(selectedSorted) === JSON.stringify(correctSorted);
		if (isCorrect) {
			dispatch('correct');
		}
	}
</script>

<div class="container">
	<div class="question">{question}</div>

	<div class="choices">
		{#each choices as choice}
			<div
				class="choice
					{submitted && !isCorrect && selected.includes(choice.label) ? 'incorrect' : ''}
					{submitted && isCorrect && selected.includes(choice.label) ? 'correct' : ''}
					{selected.includes(choice.label) ? 'selected' : ''}"
				on:click={() => toggle(choice.label)}
			>
				<div class="square">
					{#if selected.includes(choice.label)}
						<div class="filled-square"></div>
					{/if}
				</div>
				<span class="label">{choice.label}.</span>
				<span class="text">{choice.text}</span>
			</div>
		{/each}
	</div>

	{#if !isCorrect}
		<button class="submit-btn" on:click={submitAnswer}>Submit</button>
	{:else}
		<p class="feedback"> <strong>Correct!</strong></p>
	{/if}
</div>

<style>
	.container {
		max-width: 600px;
		margin: 2rem auto;
		padding: 1rem;
	}

	.question {
		font-size: 1.3rem;
		font-weight: 600;
		margin-bottom: 1rem;
		line-height: 1.4;
		text-align: left;
	}

	.choices {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.choice {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		border: 2px solid #ccc;
		border-radius: 12px;
		padding: 0.85rem 1rem;
		cursor: pointer;
		transition: all 0.2s ease;
		background-color: #fff;
	}

	.choice:hover {
		border-color: #999;
		background-color: #f8f9fa;
	}

	.label {
		font-weight: 700;
		font-family: monospace;
		color: #444;
	}

	.text {
		flex: 1;
		font-family: 'Inter', sans-serif;
		color: #222;
	}

	.square {
		width: 20px;
		height: 20px;
		border: 2px solid #999;
		border-radius: 4px;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.filled-square {
		width: 12px;
		height: 12px;
		background-color: #3b82f6;
		border-radius: 2px;
	}

	.selected {
		border-color: #3b82f6;
		background-color: #e0f2fe;
	}

	.correct {
		border-color: #22c55e;
		background-color: #dcfce7;
	}

	.incorrect {
		border-color: #ef4444;
		background-color: #fee2e2;
	}

	.submit-btn {
		margin-top: 1rem;
		padding: 0.6rem 1.2rem;
		font-size: 1rem;
		background-color: #3b82f6;
		color: white;
		border: none;
		border-radius: 8px;
		cursor: pointer;
		transition: background 0.2s ease;
	}

	.submit-btn:hover {
		background-color: #2563eb;
	}

	.feedback {
		margin-top: 1rem;
		font-weight: 600;
		font-size: 1.1rem;
	}
</style>

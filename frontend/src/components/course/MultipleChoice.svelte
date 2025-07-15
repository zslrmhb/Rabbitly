<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { fade, slide } from 'svelte/transition';

	export let question: string;
	export let choices: { label: string; text: string }[];
	export let correctAnswer: string[];

	const dispatch = createEventDispatcher();

	let selected: string = '';
	let submitted = false;
	let isCorrect = false;

	function handleClick(label: string) {
		if (isCorrect) return;
		selected = label;

		if (submitted && !isCorrect) {
			submitted = false;
		}
	}

	function submitAnswer() {
		if (!selected) return;
		submitted = true;
		isCorrect = correctAnswer.includes(selected);
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
					{selected === choice.label ? 'selected' : ''}
					{submitted && !isCorrect && selected === choice.label ? 'incorrect shake' : ''}
					{submitted && isCorrect && selected === choice.label ? 'correct' : ''}"
				on:click={() => handleClick(choice.label)}
			>
				<span class="label">{choice.label}.</span>
				<span class="text">{choice.text}</span>
			</div>
		{/each}
	</div>

	{#if !isCorrect}
		<button class="submit-btn" on:click={submitAnswer}>Submit</button>
	{/if}

	{#if submitted}
		{#if isCorrect}
			<div in:fade>
				<p class="feedback correct-text" in:slide={{ duration: 300 }}>
					<strong>Correct!</strong>
				</p>
			</div>
		{:else}
			<div in:fade>
				<p class="feedback incorrect-text" in:slide={{ duration: 300 }}>
					<strong>Try again.</strong>
				</p>
			</div>
		{/if}
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
		align-items: flex-start;
		gap: 0.5rem;
		border: 2px solid #ccc;
		border-radius: 12px;
		padding: 1rem 1.25rem;
		cursor: pointer;
		transition: all 0.2s ease;
		font-size: 1rem;
		background-color: #fff;
		box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
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

	.selected {
		border-color: #3b82f6;
		background-color: #e0f2fe;
	}

	.correct {
		border-color: #22c55e !important;
		background-color: #dcfce7 !important;
	}

	.incorrect {
		border-color: #ef4444 !important;
		background-color: #fee2e2 !important;
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

	.correct-text {
		color: #16a34a;
	}

	.incorrect-text {
		color: #dc2626;
	}

	/* Shake animation for incorrect */
	@keyframes shake {
		0% {
			transform: translateX(0);
		}
		25% {
			transform: translateX(-5px);
		}
		50% {
			transform: translateX(5px);
		}
		75% {
			transform: translateX(-5px);
		}
		100% {
			transform: translateX(0);
		}
	}

	.shake {
		animation: shake 0.3s ease-in-out;
	}
</style>

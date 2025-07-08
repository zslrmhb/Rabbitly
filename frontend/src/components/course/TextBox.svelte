<script lang="ts">
	export let paragraphs: string[] = [];
</script>

<div class="textbox">
	{#each paragraphs as text}
		<p>{text}</p>
	{/each}
</div>

<style>
	.textbox {
		background-color: #f9fafb;
		border: 1px solid #e5e7eb;
		border-radius: 0.75rem;
		padding: 1.5rem;
		margin-bottom: 1.5rem;
		font-size: 1rem;
		line-height: 1.6;
		box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
	}

	p {
		margin: 0 0 1rem;
	}

	p:last-child {
		margin-bottom: 0;
	}
</style>

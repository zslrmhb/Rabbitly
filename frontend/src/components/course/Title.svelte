<script lang="ts">
	export let text: string;
	export let level: number | string;

	// Normalize level input
	$: tag = typeof level === 'number' ? `h${level}` : level;
</script>

<svelte:element this={tag} class="title">
	{text}
</svelte:element>

<style>
	.title {
		font-weight: 700;
		margin: 1.5rem 0 1rem;
		line-height: 1.3;
	}

	h1.title {
		font-size: 2rem;
	}

	h2.title {
		font-size: 1.5rem;
	}

	h3.title {
		font-size: 1.25rem;
	}

	h4.title {
		font-size: 1rem;
	}
</style>

<script lang="ts">
	import Title from '../../../components/course/Title.svelte';
	import { DEBUG } from '$lib/config';

	interface SectionMeta {
		id: number;
		title: string;
		path: string;
		description: string;
	}

	// Define the sections of the regression course
	let sections: SectionMeta[] = [
		{
			id: 1,
			title: 'Regression Problem & Model',
			path: 'section-1',
			description: 'Learn the basics of the regression problem and the linear model.'
		},
		{
			id: 2,
			title: 'Training: Analytic Solution',
			path: 'section-2',
			description: 'Understand the least‑squares analytic solution.'
		},
		{
			id: 3,
			title: 'Training: Gradient Descent',
			path: 'section-3',
			description: 'Explore gradient descent and how it trains models.'
		},
		{
			id: 4,
			title: 'Generalization',
			path: 'section-4',
			description: 'Discover concepts of train/test, bias–variance and overfitting.'
		},
		{
			id: 5,
			title: 'Deep Learning Perspective',
			path: 'section-5',
			description: 'See linear regression from a neural‑network perspective.'
		}
	];

	// /**
	//  * Determine whether a section is unlocked.
	//  * Section 1 is always unlocked. For later sections, check localStorage for
	//  * completion of the previous section, unless DEBUG mode unlocks everything.
	//  */
	// function isSectionUnlocked(id: number): boolean {
	//   // In debug mode, unlock all sections
	//   if (DEBUG) return true;
	//   if (id === 1) return true;
	//   const prevKey = `regression_section${id - 1}_level1_complete`;
	//   return localStorage.getItem(prevKey) === 'true';
	// }
</script>

<!-- Page wrapper with white background and center-aligned content -->
<div class="min-h-screen bg-white px-4 py-8">
	<div class="mx-auto max-w-3xl">
		<Title text="Regression Course" level={1} />
		<p class="mt-2 text-gray-700">
			This interactive course on regression is divided into several sections. Each section unlocks
			after you complete the previous one. Start with Section 1 and progress through the material at
			your own pace.
		</p>

		<ul class="mt-8 grid gap-4">
			{#each sections as s}
				<a
					class="block rounded-xl border border-gray-200 bg-white p-4 shadow-sm transition hover:bg-gray-50"
					href={`/demos/regression/${s.path}`}
				>
					<h3 class="text-lg font-bold text-gray-800">{s.title}</h3>
					<p class="mt-1 text-sm text-gray-600">{s.description}</p>
				</a>
				<!-- <li>
			{#if isSectionUnlocked(s.id)}
			  <a
				class="block p-4 border border-gray-200 rounded-xl bg-white shadow-sm hover:bg-gray-50 transition"
				href={`/demos/regression/${s.path}`}
			  >
				<h3 class="font-bold text-lg text-gray-800">{s.title}</h3>
				<p class="text-sm text-gray-600 mt-1">{s.description}</p>
			  </a>
			{:else}
			  <div class="block p-4 border border-gray-200 rounded-xl bg-gray-100 text-gray-400">
				<h3 class="font-bold text-lg">{s.title}</h3>
				<p class="text-sm mt-1">{s.description}</p>
				<p class="text-sm text-red-500 mt-2">Locked</p>
			  </div>
			{/if}
		  </li> -->
			{/each}
		</ul>
	</div>
</div>

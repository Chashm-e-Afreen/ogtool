<script>
	import { selectKeywords, selectSelectedKeywords, toggleKeyword } from '@output/ContentCalendar';
</script>

<section class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50">
	<div class="mb-6 flex items-center justify-between">
		<h2 class="flex items-center gap-2 text-lg font-semibold tracking-tight text-slate-900 dark:text-white">
			<span class="flex h-8 w-8 items-center justify-center rounded-lg bg-teal-100 text-teal-600 dark:bg-teal-900/30 dark:text-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
            </span>
			Strategy Keywords
		</h2>
	</div>

	<div class="flex flex-wrap gap-2">
		{#each $selectKeywords as kw}
            {@const isSelected = $selectSelectedKeywords.includes(kw)}
			<button
				on:click={() => toggleKeyword(kw)()}
				class="cursor-pointer rounded-full border px-3 py-1.5 text-xs font-bold transition-all {isSelected
					? 'border-teal-500 bg-teal-500 text-white shadow-md'
					: 'border-slate-200 bg-white text-slate-600 hover:border-teal-200 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-400'}"
			>
				{kw}
			</button>
		{/each}
	</div>
</section>

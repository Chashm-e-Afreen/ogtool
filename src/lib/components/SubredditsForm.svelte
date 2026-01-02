<script>
	import { selectCompany, selectSelectedSubreddits, toggleSubreddit } from '@output/ContentCalendar';
</script>

<section class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50">
	<div class="mb-6 flex items-center justify-between">
		<h2 class="flex items-center gap-2 text-lg font-semibold tracking-tight text-slate-900 dark:text-white">
			<span class="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 3a3 3 0 0 0-3 3v12a3 3 0 0 0 3 3 3 3 0 0 0 3-3V6a3 3 0 0 0-3-3z"/><path d="M6 3a3 3 0 0 1 3 3v12a3 3 0 0 1-3 3 3 3 0 0 1-3-3V6a3 3 0 0 1 3-3z"/></svg>
            </span>
			Target Communities
		</h2>
	</div>

	<div class="flex flex-wrap gap-2">
		{#each $selectCompany.subreddits as sub}
            {@const isSelected = $selectSelectedSubreddits.includes(sub)}
			<button
				on:click={() => toggleSubreddit(sub)()}
				class="cursor-pointer rounded-full border px-3 py-1.5 text-xs font-bold transition-all {isSelected
					? 'border-orange-500 bg-orange-500 text-white shadow-md'
					: 'border-slate-200 bg-white text-slate-600 hover:border-orange-200 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-400'}"
			>
				{sub}
			</button>
		{/each}
	</div>
</section>

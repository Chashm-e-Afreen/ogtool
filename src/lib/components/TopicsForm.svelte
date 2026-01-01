<script>
	import { selectQueries, addQuery, onQueryTopicChange, onQueryPromptChange } from '@output/ContentCalendar';
</script>

<section class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50">
    <div class="absolute top-0 right-0 p-4 opacity-5 transition-opacity group-hover:opacity-10">
        <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="currentColor" class="text-teal-500"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
    </div>

	<div class="mb-6 flex items-center justify-between">
		<h2 class="flex items-center gap-2 text-lg font-semibold tracking-tight">
			<span class="flex h-8 w-8 items-center justify-center rounded-lg bg-teal-100 text-teal-600 dark:bg-teal-900/30 dark:text-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
            </span>
			Strategy Topics
		</h2>
		<button 
            on:click={addQuery} 
            class="flex items-center gap-1.5 rounded-lg bg-teal-50 px-3 py-1.5 text-xs font-bold text-teal-600 transition-colors hover:bg-teal-100 dark:bg-teal-900/20 dark:text-teal-400 dark:hover:bg-teal-900/40"
        >
			<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
			Add
		</button>
	</div>

	<div class="space-y-4">
		{#each $selectQueries as q, i}
			<div class="group/item rounded-xl bg-white p-3 shadow-sm ring-1 ring-slate-100 transition-all focus-within:ring-2 focus-within:ring-teal-500/20 dark:bg-slate-800 dark:ring-slate-700">
				<input
					type="text"
					placeholder="Topic (e.g., Growth Hacking)"
					value={q.topic}
					on:input={onQueryTopicChange(i)}
					class="mb-2 w-full border-b border-transparent bg-transparent pb-1 text-sm font-bold text-slate-900 placeholder:font-normal placeholder:text-slate-300 focus:border-slate-100 focus:outline-none dark:text-white dark:focus:border-slate-700"
				/>
				<textarea
					placeholder="Describe the prompt or angle..."
					value={q.prompt}
					on:input={onQueryPromptChange(i)}
					rows="2"
					class="w-full resize-none bg-transparent text-xs leading-relaxed text-slate-600 placeholder:text-slate-300 focus:outline-none dark:text-slate-400"
				></textarea>
			</div>
		{/each}
	</div>
</section>
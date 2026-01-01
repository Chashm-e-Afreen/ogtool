<script>
    import { selectCalendar, selectPostsPerWeek, nextWeek, formatTimestamp, copyToClipboard } from '@output/ContentCalendar';
</script>

<div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
	<div>
		<h2 class="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white">
            {#if $selectCalendar}
                {$selectCalendar.fcWeekId}
            {:else}
                Week 1
            {/if}
        </h2>
		<p class="text-slate-500 dark:text-slate-400">Planning {$selectPostsPerWeek} posts across targeted communities</p>
	</div>
	<button
		on:click={nextWeek}
		class="group flex cursor-pointer items-center gap-2 rounded-xl border border-slate-200 bg-white px-5 py-2.5 text-sm font-bold shadow-sm transition-all hover:-translate-y-0.5 hover:border-indigo-200 hover:shadow-md active:translate-y-0 dark:border-slate-800 dark:bg-slate-900 dark:hover:border-indigo-900"
	>
		<span class="bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent group-hover:from-indigo-500 group-hover:to-purple-500">Generate Next Week</span>
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-indigo-600 group-hover:text-indigo-500"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
	</button>
</div>

<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
	{#if $selectCalendar}
		{#each $selectCalendar.fcPosts as post}
			<div
				class="group relative flex flex-col justify-between overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm transition-all hover:-translate-y-1 hover:shadow-xl dark:border-slate-800 dark:bg-slate-900/50 dark:backdrop-blur-sm"
			>
				<!-- Card Header / Meta -->
				<div class="border-b border-slate-100 bg-slate-50/50 px-5 py-3 dark:border-slate-800 dark:bg-slate-900/50">
					<div class="flex items-center justify-between">
						<span
							class="inline-flex items-center rounded-md bg-indigo-50 px-2 py-1 text-xs font-bold text-indigo-700 ring-1 ring-inset ring-indigo-700/10 dark:bg-indigo-400/10 dark:text-indigo-400 dark:ring-indigo-400/30"
						>
							{formatTimestamp(post.pTimestamp)}
						</span>
						<div class="flex items-center gap-1.5 text-xs text-slate-500 dark:text-slate-400">
							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
							<span>Scheduled</span>
						</div>
					</div>
				</div>

				<!-- Content Preview -->
				<div class="p-5">
					<div class="mb-3 flex items-center gap-2 text-xs font-medium text-slate-500 dark:text-slate-400">
						<span class="flex items-center gap-1 hover:text-orange-500 transition-colors cursor-pointer">
							<div class="h-5 w-5 rounded-full bg-slate-200 text-[10px] flex items-center justify-center font-bold text-slate-600 dark:bg-slate-800 dark:text-slate-300">
								r/
							</div>
							r/{post.pSubreddit}
						</span>
						<span>•</span>
						<span class="flex items-center gap-1">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-slate-400"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
							{post.pAuthor.name}
						</span>
					</div>

					<p class="text-sm text-slate-600 dark:text-slate-300 line-clamp-4 leading-relaxed">
						{post.pContent}
					</p>
				</div>

				<!-- Actions -->
				<div class="mt-auto flex items-center justify-between border-t border-slate-100 p-3 dark:border-slate-800">
					<div class="text-[10px] font-medium uppercase tracking-wider text-slate-400 px-2">
						{post.pAuthor.tone}
					</div>
					<button 
						on:click={() => copyToClipboard(post.pContent)()}
						class="flex items-center gap-1.5 rounded-lg bg-indigo-600/10 px-3 py-1.5 text-xs font-bold text-indigo-600 transition-colors hover:bg-indigo-600 hover:text-white dark:bg-indigo-400/10 dark:text-indigo-400 dark:hover:bg-indigo-500 dark:hover:text-white"
					>
						View Draft
						<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/><polyline points="15 3 21 3 21 9"/><line x1="10" y1="14" x2="21" y2="3"/></svg>
					</button>
				</div>
			</div>
		{/each}
	{:else}
        <!-- Empty State just in case -->
        <div class="col-span-full flex flex-col items-center justify-center rounded-3xl border border-dashed border-slate-300 bg-slate-50/50 py-20 text-center dark:border-slate-700 dark:bg-slate-900/50">
            <p class="text-slate-500">No calendar generated yet.</p>
        </div>
	{/if}
</div>

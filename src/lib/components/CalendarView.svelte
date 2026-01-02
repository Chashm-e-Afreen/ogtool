<script>
    import { selectCalendar, selectPostsWithComments, selectPostsPerWeek, nextWeek, formatTimestamp, copyToClipboard } from '@output/ContentCalendar';
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

<!-- Switch to a masonry-like column layout for better visibility of varying heights -->
<div class="columns-1 md:columns-2 lg:columns-3 gap-6 space-y-6">
	{#if $selectPostsWithComments && $selectPostsWithComments.length > 0}
		{#each $selectPostsWithComments as item}
			<div
				class="break-inside-avoid group relative flex flex-col overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm transition-all hover:shadow-lg dark:border-slate-800 dark:bg-slate-900/50 dark:backdrop-blur-sm"
			>
				<!-- Card Header -->
				<div class="border-b border-slate-100 bg-slate-50/50 px-5 py-4 dark:border-slate-800 dark:bg-slate-900/50">
					<div class="flex items-center justify-between">
						<span
							class="inline-flex items-center rounded-md bg-indigo-50 px-2.5 py-1 text-xs font-bold text-indigo-700 ring-1 ring-inset ring-indigo-700/10 dark:bg-indigo-400/10 dark:text-indigo-400 dark:ring-indigo-400/30"
						>
							{formatTimestamp(item.post.pTimestamp)}
						</span>
						<div class="flex items-center gap-1.5 text-xs text-slate-500 dark:text-slate-400">
                            <span class="font-medium">r/{item.post.pSubreddit}</span>
						</div>
					</div>
				</div>

				<!-- Content -->
				<div class="p-5">
                    <!-- Post Author -->
					<div class="mb-4 flex items-start gap-3">
                        <div class="h-8 w-8 rounded-full bg-gradient-to-br from-indigo-400 to-purple-500 flex items-center justify-center text-white text-xs font-bold shadow-sm">
                            {item.post.pAuthor.pName.charAt(0)}
                        </div>
                        <div>
                            <div class="text-sm font-bold text-slate-900 dark:text-white">
                                {item.post.pAuthor.pName}
                            </div>
                            <div class="text-[10px] text-slate-500 leading-tight line-clamp-2" title={item.post.pAuthor.pInfo}>
                                {item.post.pAuthor.pInfo}
                            </div>
                        </div>
					</div>

                    <!-- Post Body -->
					<div class="rounded-xl bg-slate-50 p-4 text-sm text-slate-700 leading-relaxed border border-slate-100 dark:bg-slate-800/50 dark:border-slate-800 dark:text-slate-300">
						{item.post.pContent}
					</div>
                    
                    <!-- Comments Section -->
                    {#if item.comments && item.comments.length > 0}
                        <div class="mt-6">
                            <h4 class="flex items-center gap-2 text-[10px] font-bold uppercase tracking-wider text-slate-400 mb-3">
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                                {item.comments.length} Comments Planned
                            </h4>
                            <div class="space-y-3 relative before:absolute before:left-3.5 before:top-2 before:bottom-2 before:w-0.5 before:bg-slate-100 dark:before:bg-slate-800">
                                {#each item.comments as comment}
                                    <div class="relative pl-8">
                                        <!-- Thread Line Connector -->
                                        <div class="absolute left-2 top-2.5 h-px w-4 bg-slate-200 dark:bg-slate-700"></div>
                                        
                                        <div class="flex items-start gap-2 text-xs">
                                            <div class="font-bold text-slate-900 dark:text-slate-200 whitespace-nowrap">
                                                {comment.cAuthor.pName}
                                            </div>
                                            <span class="text-[10px] text-slate-400 bg-slate-100 px-1.5 py-0.5 rounded-full dark:bg-slate-800">+{comment.cDelayMinutes}m</span>
                                        </div>
                                        <div class="mt-1 text-xs text-slate-600 dark:text-slate-400 leading-relaxed">
                                            {comment.cContent}
                                        </div>
                                    </div>
                                {/each}
                            </div>
                        </div>
                    {/if}
				</div>

				<!-- Actions -->
				<div class="mt-auto flex items-center justify-end border-t border-slate-100 p-3 bg-slate-50/30 dark:border-slate-800 dark:bg-slate-900/30">
					<button 
						on:click={() => copyToClipboard(item.post.pContent)()}
						class="flex items-center gap-1.5 rounded-lg bg-white border border-slate-200 px-3 py-1.5 text-xs font-bold text-slate-600 shadow-sm transition-all hover:bg-indigo-50 hover:text-indigo-600 hover:border-indigo-200 dark:bg-slate-800 dark:border-slate-700 dark:text-slate-300 dark:hover:bg-slate-700"
					>
						<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
						Copy Post
					</button>
				</div>
			</div>
		{/each}
	{:else}
        <!-- Empty State -->
        <div class="col-span-full flex flex-col items-center justify-center rounded-3xl border border-dashed border-slate-300 bg-slate-50/50 py-20 text-center dark:border-slate-700 dark:bg-slate-900/50">
            <div class="mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-slate-100 dark:bg-slate-800">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="text-slate-400"><rect width="18" height="18" x="3" y="4" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><path d="M8 14h.01"/><path d="M12 14h.01"/><path d="M16 14h.01"/><path d="M8 18h.01"/><path d="M12 18h.01"/><path d="M16 18h.01"/></svg>
            </div>
            <h3 class="text-lg font-bold text-slate-900 dark:text-white">No calendar generated yet</h3>
            <p class="mb-8 max-w-xs text-sm text-slate-500">Your content strategy is ready to be built. Generate the first week to get started.</p>
            <button
                on:click={generate}
                class="cursor-pointer rounded-full bg-indigo-600 px-8 py-3 font-bold text-white shadow-xl shadow-indigo-500/40 transition-all hover:-translate-y-0.5 hover:bg-indigo-700 active:translate-y-0"
            >
                Generate Content Now
            </button>
        </div>
	{/if}
</div>
<script>
	// Logic from PureScript (Co-located in same directory)
	import {
		selectCalendar as calendar,
		selectPostsPerWeek as postsPerWeek,
		selectCurrentWeek as currentWeek,
		selectCompany as company,
		selectSelectedSubreddits as selectedSubreddits,
		selectKeywordsString as keywordsString,
		selectPostsWithComments as postsWithComments,
		selectSelectedPersonas as selectedPersonas,
		selectPersonas as personas,
		selectLoading as loading,
		generate,
		nextWeek,
		prevWeek,
		onPostsPerWeekChange,
		onKeywordsChange,
		toggleSubreddit,
		formatTimestamp,
		copyToClipboard
	} from '@output/ContentCalendar';
</script>

<div class="min-h-screen bg-gray-50 text-gray-900 transition-colors duration-500">
	<main class="mx-auto grid max-w-7xl grid-cols-1 gap-8 px-6 py-8 lg:grid-cols-12">
		<!-- LEFT PANEL: CONFIGURATION -->
		<aside class="space-y-6 lg:col-span-4">
			<div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
				<div class="mb-8 flex items-center justify-between">
					<h2 class="text-xs font-bold tracking-widest text-gray-400 uppercase">
						Campaign Orchestrator
					</h2>
					<span
						class="flex h-2 w-2 rounded-full {$loading
							? 'animate-pulse bg-amber-500'
							: 'bg-green-500'}"
					></span>
				</div>

				<div class="space-y-6">
					<!-- Week Selector -->
					<div>
						<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
							>Scheduling Window</label
						>
						<div class="flex items-center rounded-xl border border-gray-200 bg-gray-50 p-1">
							<button
								on:click={() => prevWeek()()}
								class="rounded-lg p-2.5 text-gray-400 shadow-sm transition hover:bg-white hover:text-indigo-600 disabled:opacity-30"
								disabled={$currentWeek <= 1}
							>
								<svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
									><path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M15 19l-7-7 7-7"
									></path></svg
								>
							</button>
							<div
								class="flex-1 text-center text-sm font-bold tracking-tighter text-gray-700 uppercase"
							>
								Week {$currentWeek}
							</div>
							<button
								on:click={() => nextWeek()()}
								class="rounded-lg p-2.5 text-gray-400 shadow-sm transition hover:bg-white hover:text-indigo-600"
							>
								<svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
									><path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M9 5l7 7-7 7"
									></path></svg
								>
							</button>
						</div>
					</div>

					<!-- Posts Per Week Slider -->
					<div>
						<div class="mb-2 flex items-center justify-between">
							<label class="block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
								>Volume (Posts/Week)</label
							>
							<span class="rounded bg-indigo-50 px-2 py-0.5 text-xs font-bold text-indigo-600"
								>{$postsPerWeek} Posts</span
							>
						</div>
						<input
							type="range"
							min="1"
							max="7"
							value={$postsPerWeek}
							on:input={(e) => onPostsPerWeekChange(e)()}
							class="h-2 w-full cursor-pointer appearance-none rounded-lg bg-gray-200 accent-indigo-600"
						/>
						<div
							class="mt-1 flex justify-between text-[9px] font-bold tracking-wider text-gray-400 uppercase"
						>
							<span>Low</span>
							<span>Max (7)</span>
						</div>
					</div>

					<!-- Subreddits -->
					<div>
						<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
							>Target Subreddits</label
						>
						<div class="flex flex-wrap gap-2">
							{#each $company.subreddits as sub}
								{@const isSelected = $selectedSubreddits.includes(sub)}
								<button
									on:click={() => toggleSubreddit(sub)()}
									class="rounded-lg border px-3 py-1.5 text-xs transition-all {isSelected
										? 'border-indigo-600 bg-indigo-600 text-white shadow-md'
										: 'border-gray-200 bg-white text-gray-500 hover:border-indigo-300'}"
								>
									{sub}
								</button>
							{/each}
						</div>
					</div>

					<!-- Keywords -->
					<div>
						<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
							>Contextual Lenses</label
						>
						<textarea
							value={$keywordsString}
							on:input={(e) => onKeywordsChange(e)()}
							class="min-h-[100px] w-full rounded-xl border border-gray-200 p-3 text-sm shadow-sm transition-all outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10 dark:bg-white"
							placeholder="e.g. pain points, specific product features..."
						></textarea>
					</div>

					<!-- Main Button -->
					<button
						on:click={() => generate()()}
						disabled={$loading}
						class="flex w-full transform items-center justify-center gap-2 rounded-xl bg-gray-900 py-4 font-bold text-white shadow-xl transition-all hover:-translate-y-0.5 hover:bg-black hover:shadow-2xl disabled:transform-none disabled:bg-gray-400"
					>
						<span>{$loading ? 'Generating...' : 'Regenerate Calendar'}</span>
					</button>
				</div>
			</div>

			<!-- Testing Note -->
			<div class="rounded-xl border border-indigo-100 bg-indigo-50 p-4">
				<h4 class="mb-2 text-[10px] font-bold tracking-widest text-indigo-400 uppercase">
					Testing Note
				</h4>
				<p class="text-[11px] leading-relaxed text-indigo-700">
					Hover over user avatars in the feed to audit their AI background profiles. Verify
					narrative alignment across threads.
				</p>
			</div>
		</aside>

		<!-- RIGHT PANEL: CONTENT FEED -->
		<div class="lg:col-span-8">
			<div class="space-y-8">
				<div class="flex items-center justify-between px-2">
					<h2 class="text-lg font-extrabold tracking-tight text-gray-900">Active Threads</h2>
					<div class="flex items-center gap-2">
						<span class="font-mono text-[10px] text-gray-400"
							>Total Units: {$postsWithComments.length}</span
						>
					</div>
				</div>

				<!-- Feed Container -->
				<div class="space-y-8">
					{#if $postsWithComments.length > 0}
						{#each $postsWithComments as item, i}
							<div
								class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm transition-colors hover:border-indigo-200"
							>
								<div
									class="flex items-center justify-between border-b border-gray-100 bg-gray-50/50 px-6 py-4"
								>
									<div class="flex items-center gap-3">
										<span
											class="rounded bg-gray-800 px-2 py-0.5 text-[10px] font-black tracking-widest text-white uppercase"
											>OP</span
										>
										<span class="text-xs font-bold text-indigo-600">r/{item.post.pSubreddit}</span>
									</div>
									<span class="rounded bg-gray-100 px-2 py-1 font-mono text-[10px] text-gray-400"
										>ID: P{i}</span
									>
								</div>
								<div class="p-6">
									<div class="flex gap-5">
										<div class="group relative flex-shrink-0 cursor-help">
											<div
												class="flex h-12 w-12 items-center justify-center rounded-2xl bg-blue-100 text-base font-black text-blue-700 shadow-inner"
											>
												{item.post.pAuthor.pName
													.split(' ')
													.map((n) => n[0])
													.join('')}
											</div>
											<!-- Tooltip -->
											<div
												class="bg-opacity-95 invisible absolute bottom-full left-0 z-50 mb-3 w-72 rounded-xl border border-gray-700 bg-gray-900 p-4 text-[11px] text-white shadow-2xl backdrop-blur-sm group-hover:visible"
											>
												<p
													class="mb-2 border-b border-gray-700 pb-2 text-[9px] font-bold tracking-widest text-indigo-400 uppercase"
												>
													Persona Identity Profile
												</p>
												<p class="leading-relaxed opacity-90">{item.post.pAuthor.pInfo}</p>
												<div
													class="absolute -bottom-1 left-5 h-2 w-2 rotate-45 border-r border-b border-gray-700 bg-gray-900"
												></div>
											</div>
										</div>
										<div class="flex-1">
											<div class="mb-2 flex items-center justify-between">
												<h3 class="text-sm font-extrabold text-gray-900">
													{item.post.pAuthor.pName}
												</h3>
												<div class="flex items-center gap-3">
													<span class="text-[10px] font-medium text-gray-400"
														>Scheduled: {formatTimestamp(item.post.pTimestamp)}</span
													>
													<button
														on:click={() => copyToClipboard(item.post.pContent)()}
														class="text-gray-400 transition-colors hover:text-indigo-600"
														title="Copy Post"
													>
														<svg
															xmlns="http://www.w3.org/2000/svg"
															width="14"
															height="14"
															viewBox="0 0 24 24"
															fill="none"
															stroke="currentColor"
															stroke-width="2"
															stroke-linecap="round"
															stroke-linejoin="round"
															><rect x="9" y="9" width="13" height="13" rx="2" ry="2" /><path
																d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"
															/></svg
														>
													</button>
												</div>
											</div>
											<p
												class="text-[13px] leading-relaxed font-medium whitespace-pre-wrap text-gray-700"
											>
												{item.post.pContent}
											</p>
										</div>
									</div>

									<!-- Comments -->
									{#if item.comments.length > 0}
										<div class="mt-8 ml-10 space-y-6 border-l-2 border-gray-100 pl-6">
											{#each item.comments as comment}
												<div class="flex gap-4">
													<div class="group relative flex-shrink-0 cursor-help">
														<div
															class="flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-100 text-xs font-black text-emerald-700"
														>
															{comment.cAuthor.pName
																.split(' ')
																.map((n) => n[0])
																.join('')}
														</div>
														<!-- Tooltip -->
														<div
															class="invisible absolute bottom-full left-0 z-50 mb-3 w-64 rounded-xl border border-gray-700 bg-gray-900 p-4 text-[11px] text-white shadow-2xl group-hover:visible"
														>
															<p
																class="mb-2 border-b border-gray-700 pb-2 text-[9px] font-bold tracking-widest text-indigo-400 uppercase"
															>
																Persona Identity Profile
															</p>
															<p class="leading-relaxed opacity-90">{comment.cAuthor.pInfo}</p>
														</div>
													</div>
													<div
														class="flex-1 rounded-2xl rounded-tl-none border border-gray-100/50 bg-gray-50/80 p-4"
													>
														<div class="mb-1.5 flex items-center justify-between">
															<h4 class="text-xs font-black text-gray-900">
																{comment.cAuthor.pName}
															</h4>
															<span
																class="text-[9px] font-bold tracking-widest text-gray-400 uppercase"
																>+{comment.cDelayMinutes}m delay</span
															>
														</div>
														<p class="text-[13px] leading-normal text-gray-600">
															{comment.cContent}
														</p>
													</div>
												</div>
											{/each}
										</div>
									{/if}
								</div>
							</div>
						{/each}
					{:else}
						<!-- Empty State -->
						<div
							class="flex flex-col items-center justify-center rounded-3xl border border-dashed border-gray-300 bg-white py-20 text-center"
						>
							<div class="mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-gray-50">
								<svg
									xmlns="http://www.w3.org/2000/svg"
									width="32"
									height="32"
									viewBox="0 0 24 24"
									fill="none"
									stroke="currentColor"
									stroke-width="1.5"
									stroke-linecap="round"
									stroke-linejoin="round"
									class="text-gray-400"
									><rect width="18" height="18" x="3" y="4" rx="2" ry="2" /><line
										x1="16"
										y1="2"
										x2="16"
										y2="6"
									/><line x1="8" y1="2" x2="8" y2="6" /><line x1="3" y1="10" x2="21" y2="10" /><path
										d="M8 14h.01"
									/><path d="M12 14h.01" /><path d="M16 14h.01" /><path d="M8 18h.01" /><path
										d="M12 18h.01"
									/><path d="M16 18h.01" /></svg
								>
							</div>
							<h3 class="text-lg font-bold text-gray-900">No calendar generated yet</h3>
							<p class="mb-8 max-w-xs text-sm text-gray-500">
								Adjust your parameters and click regenerate to build your content strategy.
							</p>
							<button
								on:click={() => generate()()}
								disabled={$loading}
								class="cursor-pointer rounded-full bg-indigo-600 px-8 py-3 font-bold text-white shadow-xl shadow-indigo-500/40 transition-all hover:-translate-y-0.5 hover:bg-indigo-700 active:translate-y-0 disabled:bg-gray-400"
							>
								{$loading ? 'Generating...' : 'Generate Content Now'}
							</button>
						</div>
					{/if}
				</div>
			</div>
		</div>
	</main>
</div>

<style>
	.group:hover .invisible {
		visibility: visible;
		opacity: 1;
	}
</style>
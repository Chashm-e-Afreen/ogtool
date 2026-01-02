<script>
	import { selectPostsWithComments as postsWithComments } from '@output/ContentCalendar.Selectors';
	import PostCard from './PostCard.svelte';
	import EmptyState from './EmptyState.svelte';
</script>

<div class="lg:col-span-8">
	<div class="space-y-8">
		<div class="flex items-center justify-between px-2">
			<h2 class="text-lg font-extrabold tracking-tight text-gray-900">Active Threads</h2>
		</div>

		<div class="space-y-8">
			{#if $postsWithComments.length > 0}
				{#each $postsWithComments as item, i}
					<PostCard {item} index={i} />
				{/each}
			{:else}
				<EmptyState />
			{/if}
		</div>
	</div>
</div>

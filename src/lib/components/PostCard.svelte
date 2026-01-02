<script>
    import { formatTimestamp, copyToClipboard } from '@output/ContentCalendar';
    import CommentItem from './CommentItem.svelte';

    export let item;
    export let index;
</script>

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
            >ID: P{index}</span
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
                            class="cursor-pointer text-gray-400 transition-colors hover:text-indigo-600"
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
                    <CommentItem {comment} />
                {/each}
            </div>
        {/if}
    </div>
</div>

<style>
	.group:hover .invisible {
		visibility: visible;
		opacity: 1;
	}
</style>

<script lang="ts">
    import { onMount } from 'svelte';
    import { goto } from '$app/navigation';
    
    export let instructions: string = `
        <h3 class="text-xl font-bold text-primary mb-4">Two Sum</h3>
        <p class="mb-4">
            Given an array of integers <code class="bg-base-300 px-2 py-1 rounded">nums</code> and an integer <code class="bg-base-300 px-2 py-1 rounded">target</code>, 
            return indices of the two numbers such that they add up to target.
        </p>
        <p class="mb-4">
            You may assume that each input would have exactly one solution, and you may not use the same element twice.
        </p>
        <div class="bg-base-300 p-4 rounded-lg mb-4">
            <div><strong>Input:</strong> nums = [2,7,11,15], target = 9</div>
            <div><strong>Output:</strong> [0,1]</div>
            <div><strong>Explanation:</strong> Because nums[0] + nums[1] == 9, we return [0, 1].</div>
        </div>
    `;
    
    let code = '';
    let output = '';
    let running = false;
    let timer = 0;
    let timerInterval: number;

    async function run() {
        running = true;
        output = 'Running...';
        
        try {
            // Simple evaluation - in a real app you'd want a safer sandbox
            const result = eval(code);
            output = typeof result === 'function' ? 'Function defined successfully' : String(result);
        } catch (e) {
            output = `Error: ${e.message}`;
        } finally {
            await new Promise((r) => setTimeout(r, 500));
            running = false;
        }
    }

    function close() {
        if (timerInterval) clearInterval(timerInterval);
        goto('/');
    }

    function startTimer() {
        timerInterval = setInterval(() => {
            timer += 1;
        }, 1000);
    }

    function formatTime(seconds: number): string {
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }

    onMount(() => {
        code = `// Write your solution here
function twoSum(nums, target) {
    const map = new Map();
    
    for (let i = 0; i < nums.length; i++) {
        const complement = target - nums[i];
        
        if (map.has(complement)) {
            return [map.get(complement), i];
        }
        
        map.set(nums[i], i);
    }
    
    return [];
}

// Test the function
console.log(twoSum([2, 7, 11, 15], 9));`;
        
        startTimer();
        
        return () => {
            if (timerInterval) clearInterval(timerInterval);
        };
    });
</script>

<div class="h-screen flex flex-col bg-base-100">
    <!-- Top Bar -->
    <div class="flex items-center gap-4 p-4 bg-base-200 border-b border-base-300">
        <!-- Exit Button -->
        <button
            class="btn btn-square btn-error btn-sm"
            on:click={close}
            aria-label="Close Editor"
        >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
        </button>

        <!-- Progress Bar -->
        <div class="flex-1">
            <progress 
                class="progress progress-success w-full" 
                value={running ? 45 : 100} 
                max="100"
            ></progress>
        </div>

        <!-- Timer -->
        <div class="text-sm opacity-70 font-mono">
            {formatTime(timer)}
        </div>
    </div>

    <!-- Main Content Grid -->
    <div class="flex-1 grid grid-cols-2 gap-4 p-4 overflow-hidden">
        <!-- Instructions Panel -->
        <div class="bg-base-200 rounded-lg flex flex-col overflow-hidden">
            <div class="bg-base-300 px-4 py-3 font-semibold border-b border-base-content/10">
                Instructions
            </div>
            <div class="flex-1 p-4 overflow-auto">
                <div class="prose prose-sm max-w-none">
                    {@html instructions}
                </div>
            </div>
        </div>

        <!-- Code & Output Panel -->
        <div class="flex flex-col gap-4 overflow-hidden">
            <!-- Code Editor -->
            <div class="bg-base-200 rounded-lg flex flex-col overflow-hidden flex-1">
                <div class="bg-base-300 px-4 py-3 font-semibold border-b border-base-content/10 flex items-center justify-between">
                    <span>Code Editor</span>
                    <button 
                        class="btn btn-primary btn-sm"
                        on:click={run}
                        disabled={running}
                        class:loading={running}
                    >
                        {running ? 'Running...' : 'Run Code'}
                    </button>
                </div>
                <div class="flex-1 p-4">
                    <textarea 
                        bind:value={code}
                        class="textarea textarea-bordered w-full h-full resize-none font-mono text-sm bg-base-100"
                        placeholder="Write your code here..."
                        spellcheck="false"
                    ></textarea>
                </div>
            </div>

            <!-- Output Panel -->
            <div class="bg-base-200 rounded-lg flex flex-col overflow-hidden h-48">
                <div class="bg-base-300 px-4 py-3 font-semibold border-b border-base-content/10">
                    Output
                </div>
                <div class="flex-1 p-4 overflow-auto">
                    <pre class="text-sm font-mono whitespace-pre-wrap break-words">{output}</pre>
                </div>
            </div>
        </div>
    </div>
</div>
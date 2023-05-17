<script setup lang="ts">

const { setFlag } = useFlagStore();
const task = ref('');

const handleClick = () => {
    const currentUrl = window.location.href;
    useFetch(currentUrl + 'api/todos', {
        method: 'post',
        body: { "content": task.value },
    });
    task.value = '';
    setFlag(true);
};
</script>

<template>
    <div>
        <form>
            <div class="input-group">
                <input class="form-control" type="text" placeholder="write your something to do" v-model="task">
                <span class="input-group-button">
                    <button class="btn" type="button" aria-label="Copy to clipboard" @click="handleClick">
                        confirm
                    </button>
                </span>
            </div>
        </form>
    </div>
</template>

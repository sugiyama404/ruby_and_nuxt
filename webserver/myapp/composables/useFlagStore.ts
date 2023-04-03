import { Ref } from "nuxt/dist/app/compat/capi";

type FlagState = {
    flag: boolean;
};

export const useFlagStore = () => {
    const state = useState<FlagState>("flag_state", () => ({
        flag: false,
    }));
    return {
        state: readonly(state),
        setFlag: setFlag(state),
        deleteTodo: deleteTodo(state),
    };
};

const setFlag = (state: Ref<FlagState>) => {
    return (flag: boolean) => (state.value.flag = flag);
};

const deleteTodo = (state: Ref<FlagState>) => {
    return (num: string) => {
        const currentUrl = window.location.href
        useFetch(currentUrl + 'api/todos/' + num, { method: "delete", })
        state.value.flag = true
    };
};

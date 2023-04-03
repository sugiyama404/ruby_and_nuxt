type TodoState = {
  id: number
  content: string
}

export const UseTodoState = () => {
  const todo_data = show();
  //const todo_state = useState<TodoState>(() => { return data });
  return {
    todo_data
  };
};

const show = () => {
  const currentUrl = window.location.href;
  const data = useFetch(currentUrl + 'api/todos', { method: "get", });
  return data;
};



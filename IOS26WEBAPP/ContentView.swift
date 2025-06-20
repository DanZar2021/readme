import SwiftUI

struct ContentView: View {
    @State private var items: [TodoItem] = []
    @State private var newItem = ""

    var body: some View {
        ZStack {
            // Background for liquid glass effect
            LinearGradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                GlassCard {
                    HStack {
                        TextField("Add task", text: $newItem)
                            .textFieldStyle(.plain)
                        Button(action: addItem) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }

                List {
                    ForEach(items) { item in
                        GlassCard {
                            HStack {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture { toggle(item) }
                                Text(item.title)
                                    .strikethrough(item.isDone)
                                    .foregroundColor(item.isDone ? .secondary : .primary)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
            }
            .padding()
        }
    }

    func addItem() {
        guard !newItem.isEmpty else { return }
        items.append(TodoItem(title: newItem))
        newItem = ""
    }

    func toggle(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isDone.toggle()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct GlassCard<Content: View>: View {
    var content: () -> Content

    var body: some View {
        content()
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.white.opacity(0.2))
            )
    }
}

#Preview {
    ContentView()
}

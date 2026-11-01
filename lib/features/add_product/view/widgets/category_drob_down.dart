part of '../add_product_screen.dart';

class CategoryDrobDown extends StatelessWidget {
  const CategoryDrobDown({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle('Category', required: true),
        DropdownButtonFormField<RequestCategories>(
          initialValue: cubit.selectedCategory,
          hint: Text(
            'Select category',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          isExpanded: true,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color(0xFF92989A), fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: cubit.categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: (value) {
            cubit.changeCategory(value);
          },
          validator: (value) =>
              value == null ? 'Please select a category' : null,
        ),
      ],
    );
  }
}

part of '../add_product_screen.dart';

class IamgePickSection extends StatelessWidget {
  const IamgePickSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddProductCubit>();
    return Column(
      children: [
        // GestureDetector(
        //   onTap: () => cubit.pickImage(),
        //   child: Container(
        //     height: 145,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(13),
        //       border: Border.all(
        //         color: const Color(0xFFCAD5D2),
        //         style: BorderStyle.solid,
        //       ),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const [
        //         Icon(
        //           Icons.add_photo_alternate_outlined,
        //           size: 42,
        //           color: AppColors.primaryColor,
        //         ),
        //         SizedBox(height: 9),
        //         Text(
        //           'Add Product Images',
        //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        //         ),
        //         SizedBox(height: 5),
        //         Text(
        //           'Tap to upload or choose from gallery',
        //           style: TextStyle(fontSize: 12, color: Colors.grey),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(3, (index) {
            final hasImage = index < cubit.images.length;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 2 ? 0 : 8),
                child: GestureDetector(
                  onTap: () {
                    if (hasImage) {
                      return;
                    } else {
                      cubit.pickImage();
                    }
                  },
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE5E9E8)),
                    ),
                    child: hasImage
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  cubit.images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              hasImage
                                  ? Positioned(
                                      right: 0,

                                      child: GestureDetector(
                                        onTap: () => cubit.deleteImage(index),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          )
                        : const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.grey,
                            size: 22,
                          ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

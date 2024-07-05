import 'package:ecohouse/core/features/shop/bloc/shop_bloc.dart';
import 'package:ecohouse/core/features/shop/bloc/shop_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/item.dart';

class ShopCard2 extends StatelessWidget {
  final ItemModule item;
  const ShopCard2({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ShopBloc>(context);

    return GestureDetector(
        onLongPress: () {
          context.read<ShopBloc>().add(ToggaleItemEvent(item: item));
        },
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: EdgeInsets.only(bottom: 10.h),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide.none,
            ),
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 150.h,
                    color: Colors.grey[300],
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$${item.points}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          item.description,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 12.w),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    bloc.add(
                                        DecrementItemEvent(itemId: item.id));
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    bloc.add(
                                        IncrementItemEvent(itemId: item.id));
                                  },
                                ),
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                bloc.add(DeleteItemEvent(item: item));
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
